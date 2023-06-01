//
//  CartVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.04.2022.
//

import UIKit
import FittedSheets
import SVProgressHUD
import MBCheckboxButton

class CartVC: UIViewController, PickerDelegate, WarningDelegate, CargoTypeSelected{
    let mainView = CartView()
    var carts: [CartProduct]?
    let refreshController = UIRefreshControl()
    var wait = UIView()
    var showPrice = true
    var cargoType = 0
    var cargoPrice: Double = 0
    var selectedCartIds = [String]()
    var selectedCarts = [CartProduct]()
    var products = [Product]()
    var delivery: Delivery?
    let day = "gun".localized()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let auth = UserDefaults.standard.bool(forKey: "auth")
        if !auth {
            showAuthVC()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carts = []
//        call(loadData, and: checkProducts)
        loadData()
        checkProducts()
    }
    
    private func setupUI(){
        wait = Components.shared.waitDialog(view: view)
        view = mainView
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
//        refreshController.attributedTitle = NSAttributedString(string: "Refresh")
        refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
        mainView.tableView.addSubview(refreshController)
        mainView.bottomCallback = {[weak self] in
            self?.showBottomPriceView()
        }
        let viewRec = UITapGestureRecognizer(target: self, action: #selector(clickView))
        mainView.blackView.isUserInteractionEnabled = true
        mainView.blackView.addGestureRecognizer(viewRec)
        mainView.aproveBtn.isEnabled = false
        mainView.aproveBtn.alpha = 0.5
    }
    
    func showAuthVC(){
        let vc = LoginVC()
        let navBar = UINavigationController(rootViewController: vc)
        navBar.modalPresentationStyle = .fullScreen
        present(navBar, animated: true, completion: {
            self.tabBarController?.selectedIndex = 0
        })
    }
    
    func loadData(){
        Network.shared.getUserCart {[self] error in
            view.isUserInteractionEnabled = true
            wait.removeFromSuperview()
            SVProgressHUD.dismiss()
            print(error)
            let error = Components.shared.getErrorDialog(message: error)
            present(error, animated: true, completion: nil)
        } success: {[self] carts in
            view.isUserInteractionEnabled = true
            wait.removeFromSuperview()
            delivery = carts.meta
            SVProgressHUD.dismiss()
            self.carts = carts.products
            mainView.priceView.deliveryDayValueLb.text = "\(carts.meta?.normal_delivery_day ?? "0") \(day)"
            mainView.priceView.deliveryPriceValueLb.text = "\(carts.meta?.normal_delivery_price ?? "0") TMT"
            cargoPrice = Double(delivery?.normal_delivery_price ?? "") ?? 0
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                mainView.tableView.reloadData()
                calculate()
                mainView.aproveBtn.addTarget(self, action: #selector(clickOrder), for: .touchUpInside)
                if carts.products?.count == 0 || carts.products == nil{
                    mainView.tableView.isHidden = true
                    mainView.noCartLb.isHidden = false
                    mainView.noCartImg.isHidden = false
                }else{
                    mainView.tableView.isHidden = false
                    mainView.noCartLb.isHidden = true
                    mainView.noCartImg.isHidden = true
                }
            }
        }
    }
    
    func checkProducts(){
        Network.shared.checkProduct {[self] error in
            view.isUserInteractionEnabled = true
            wait.removeFromSuperview()
            SVProgressHUD.dismiss()
            print(error)
            let error = Components.shared.getErrorDialog(message: error)
            present(error, animated: true, completion: nil)
        } success: {[self] products in
            guard var carts = carts else {return}
            if carts.count == 0 {return}
            self.products = products
            for i in products.indices{
                if (products[i].sale_price ?? -1) != (carts[i].sale_price ?? -1){
                    carts[i].sale_price = products[i].sale_price
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                mainView.tableView.reloadData()
                calculate()
                mainView.aproveBtn.isEnabled = true
                UIView.animate(withDuration: 0.3) {
                    mainView.aproveBtn.alpha = 1
                }
                mainView.aproveBtn.addTarget(self, action: #selector(clickOrder), for: .touchUpInside)
            }
        }
    }
    
    func calculate(){
        if selectedCartIds.count > 0{
            var sum: Double = 0
            var discount: Double = 0
            selectedCarts.forEach { cart in
                sum += Double(cart.count ?? 1) * (cart.sale_price ?? 0)
                discount += Double(cart.count ?? 1) * (cart.price ?? (cart.sale_price ?? 0))
            }
            if discount > sum{
                mainView.priceView.priceValueLb.makeDiscount(price: "\(discount.rounded(places: 2))")
            }else{
                mainView.priceView.priceValueLb.makeDiscount(price: "0.0")
            }
            sum += cargoPrice
            mainView.sumValueLb.text = "\(sum.rounded(places: 2)) TMT"
            mainView.priceView.salePriceValueLb.text = "\(sum.rounded(places: 2)) TMT"
        }else{
            var sum: Double = 0
            var discount: Double = 0
            carts?.forEach { cart in
                sum += Double(cart.count ?? 1) * (cart.sale_price ?? 0)
                discount += Double(cart.count ?? 1) * (cart.price ?? (cart.sale_price ?? 0))
            }
            if discount > sum {
                mainView.priceView.priceValueLb.makeDiscount(price: "\(discount.rounded(places: 2))")
            }else{
                mainView.priceView.priceValueLb.makeDiscount(price: "0.0")
            }
            sum += cargoPrice
            mainView.sumValueLb.text = "\(sum.rounded(places: 2)) TMT"
            mainView.priceView.salePriceValueLb.text = "\(sum.rounded(places: 2)) TMT"
        }
    }
    
    @objc func refresh(){
        refreshController.endRefreshing()
        wait = Components.shared.waitDialog(view: view)
        carts = nil
        products = []
        mainView.tableView.reloadData()
        loadData()
        checkProducts()
    }
    
    func pcickerSelected(row: Int, tableRow: Int, changeSize: Bool, cartId: String, size: Size?) {
        if changeSize {
            guard let size = size else { return }
            let wait = Components.shared.waitDialog(view: view)
            Network.shared.modifyCartSize(size: size, cartId: cartId) { [self] error in
                print(error)
                SVProgressHUD.dismiss()
                wait.removeFromSuperview()
                view.isUserInteractionEnabled = true
                let error = Components.shared.getErrorDialog(message: error)
                present(error, animated: true, completion: nil)
            } success: {[self] in
                SVProgressHUD.dismiss()
                wait.removeFromSuperview()
                view.isUserInteractionEnabled = true
                carts?[tableRow].size = size.value
                mainView.tableView.reloadData()
            }
        }else{
            let wait = Components.shared.waitDialog(view: view)
            Network.shared.setCartCount(cartId: carts?[tableRow].cart_id?.stringValue ?? "", count: "\(row+1)") {[self] error in
                print(error)
                SVProgressHUD.dismiss()
                wait.removeFromSuperview()
                view.isUserInteractionEnabled = true
                let error = Components.shared.getErrorDialog(message: error)
                present(error, animated: true, completion: nil)
            } succuss: {[self] in
                SVProgressHUD.dismiss()
                wait.removeFromSuperview()
                view.isUserInteractionEnabled = true
                carts?[tableRow].count = row+1
                calculate()
                mainView.tableView.reloadData()
            }
        }
    }
    
//    MARK: TO remove CART Make Count 0-
    func acceptClicked(row: Int?) {
        guard let row = row else { return }
        let wait = Components.shared.waitDialog(view: view)
        Network.shared.setCartCount(cartId: carts?[row].cart_id?.stringValue ?? "", count: "\(0)") {[self] error in
            print(error)
            SVProgressHUD.dismiss()
            wait.removeFromSuperview()
            view.isUserInteractionEnabled = true
            let error = Components.shared.getErrorDialog(message: error)
            present(error, animated: true, completion: nil)
        } succuss: {[self] in
            SVProgressHUD.dismiss()
            wait.removeFromSuperview()
            view.isUserInteractionEnabled = true
            carts?.remove(at: row)
            calculate()
            mainView.tableView.reloadData()
        }
    }
    
    func showBottomPriceView(){
        if showPrice{
            mainView.showPriceView()
        }else{
            mainView.hidePriceView()
        }
        showPrice = !showPrice
    }
    
    @objc func clickView(){
        if !showPrice{
            showBottomPriceView()
        }
    }
    
    @objc func clickOrder(){
        let alert = UIAlertController(title: "Alert".localized(), message: "Sargyt etjekmi?".localized(), preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok".localized(), style: .default) {[self] _ in
            let wait = Components.shared.waitDialog(view: view)
            Network.shared.createUserOrder(cargo_type: cargoType, selected: selectedCartIds) {[self] error in
                print(error)
                SVProgressHUD.dismiss()
                wait.removeFromSuperview()
                view.isUserInteractionEnabled = true
                let error = Components.shared.getErrorDialog(message: error)
                present(error, animated: true, completion: nil)
            } success: {[self] in
                SVProgressHUD.dismiss()
                wait.removeFromSuperview()
                view.isUserInteractionEnabled = true
                SVProgressHUD.showSuccess(withStatus: "Product added")
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    SVProgressHUD.dismiss()
                }
//                if carts?.count == 0{
//                    mainView.tableView.isHidden = true
//                    mainView.sumValueLb.text = "0 TMT"
//                    mainView.priceView.priceValueLb.text = "0 TMT"
//                    mainView.priceView.salePriceValueLb.text = "0 TMT"
//                }else{
//                    mainView.tableView.isHidden = false
//                }
//                mainView.tableView.reloadData()
                loadData()
                checkProducts()
            }
        }
        let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: TableView cell's Methods-
extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((carts?.count ?? -1) + 1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != carts?.count{
            return 120 * widthRatio
        }else{
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (carts?.count ?? -1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CargoTypeCell", for: indexPath) as! CargoTypeCell
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
            guard let cart = carts?[indexPath.row] else { return cell }
            if selectedCartIds.contains(cart.cart_id?.stringValue ?? ""){
                cell.checkBoxBtn.setImage(UIImage(named: "checkbox-checked-1"), for: .normal)
                cell.checkBoxBtn.isSelected = true
                cell.checkBoxBtn.imageView?.tintColor = .mainColor
            }else{
                cell.checkBoxBtn.setImage(UIImage(named: "checkbox-unchecked"), for: .normal)
                cell.checkBoxBtn.isSelected = false
            }
            cell.removeCallback = {[weak self] in
                self?.clickRemove(row: indexPath.row)
            }
            cell.countCallback = {[weak self] in
                self?.clickCount(tableRow: indexPath.row, size: nil, cartId: cart.cart_id?.stringValue ?? "")
            }
            cell.checkBtnCallback = {[weak self] in
                self?.clickCheckBtn(btn: cell.checkBoxBtn, row: indexPath.row)
            }
            cell.sizeCallback = {[weak self] in
                self?.clickCount(tableRow: indexPath.row, size: self?.products[indexPath.row].sizes, cartId: cart.cart_id?.stringValue ?? "")
            }
            cell.initData(cart: cart)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextAction = UIContextualAction(style: .destructive, title: "remove".localized()) { action, sourceView, completion in
            self.clickRemove(row: indexPath.row)
            completion(true)
        }
        let configure = UISwipeActionsConfiguration(actions: [contextAction])
        return configure
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
//    MARK: Actions -
    
    func clickCheckBtn(btn: UIButton, row: Int){
        guard let cart = carts?[row] else { return }
        btn.isSelected = btn.isSelected ? false : true
        if btn.isSelected {
            selectedCarts.append(cart)
            selectedCartIds.append(cart.cart_id?.stringValue ?? "")
            btn.setImage(UIImage(named: "checkbox-checked-1"), for: .normal)
            btn.imageView?.tintColor = .mainColor
        }else{
            btn.setImage(UIImage(named: "checkbox-unchecked"), for: .normal)
            var count = 0
            for i in selectedCartIds{
                if i == (carts?[row].cart_id?.stringValue ?? ""){
                    selectedCarts.remove(at: count)
                    selectedCartIds.remove(at: count)
                }
                count += 1
            }
        }
        calculate()
    }
    
    func clickRemove(row: Int){
        var sheetOptions = SheetOptions()
        sheetOptions.presentingViewCornerRadius = 16
        sheetOptions.pullBarHeight = 0
        sheetOptions.shouldExtendBackground = false
        sheetOptions.shrinkPresentingViewController = false
        sheetOptions.transitionVelocity = 0
        sheetOptions.transitionDampening = 1
        let vc = WarningVC()
        vc.delegate = self
        vc.row = row
        let sheetVC = SheetViewController(controller: vc, sizes: [.fixed(183*widthRatio)], options: sheetOptions)
        present(sheetVC, animated: true, completion: nil)
    }
    
    func clickCount(tableRow: Int, size: [Size]?, cartId: String){
        var sheetOptions = SheetOptions()
        sheetOptions.presentingViewCornerRadius = 16
        sheetOptions.pullBarHeight = 0
        sheetOptions.shouldExtendBackground = false
        sheetOptions.shrinkPresentingViewController = false
        sheetOptions.transitionVelocity = 0
        sheetOptions.transitionDampening = 1
        let vc = PickerVC()
        vc.sizes = size
        vc.cartId = cartId
        vc.title = "Count".localized()
        vc.tableRow = tableRow
        vc.delegate = self
        let sheetVC = SheetViewController(controller: vc, sizes: [.fixed(300*widthRatio)], options: sheetOptions)
        present(sheetVC, animated: true, completion: nil)
    }
    
    func selected(index: Int) {
        if index == 0{
            mainView.priceView.deliveryDayValueLb.text = "\(delivery?.normal_delivery_day ?? "0") \(day)"
            mainView.priceView.deliveryPriceValueLb.text = delivery?.normal_delivery_price
            cargoPrice = Double(delivery?.normal_delivery_price ?? "") ?? 0
        }else{
            mainView.priceView.deliveryDayValueLb.text = "\(delivery?.express_delivery_day ?? "0") \(day)"
            mainView.priceView.deliveryPriceValueLb.text = "\(delivery?.express_delivery_price ?? "") TMT"
            cargoPrice = Double(delivery?.express_delivery_price ?? "") ?? 0
        }
        calculate()
        cargoType = index
    }
}
