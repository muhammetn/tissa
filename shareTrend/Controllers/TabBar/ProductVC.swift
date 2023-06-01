//
//  ProductVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.04.2022.
//

import UIKit
import SVProgressHUD
import SkeletonView

class ProductVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchControllerDelegate, HeaderDelegate{
    
    let mainView = ProductView()
    let blackView = UIView()
    let searchController = UISearchController()
    var product: Product?
    var selectedSize: Size?
    var lastProd = [RandomProduct]()
    var lastUrl = String()
    let suiteName = "group.trendCopy"
    let interactor = Interactor()
    var isProductShowed = false
    var showSkeleton = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let auth = UserDefaults.standard.bool(forKey: "auth")
//        if !auth {
//            showAuthVC()
//        }
    }
    
//    @objc private func observeNotify(notification: Notification) {
//        print("OBJECT: \(notification.userInfo)")
//        guard let content = notification.userInfo?["content"] as? String else {return}
//        print("content: \(content), \(url)")
//    }
    
    private func setupUI(){
        view = mainView
        mainView.bottomView.isHidden = true
        mainView.collectionView.isScrollEnabled = false
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setUrl),
//            name: UIApplication.didBecomeActiveNotification,
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
//        NotificationCenter.default.addObserver(self, selector: #selector(observeNotify(notification:)), name: Notification.Name("copiedUrl"), object: nil)
        searchController.delegate = self
        let searchBar = searchController.searchBar
        searchController.loadViewIfNeeded()
        searchBar.placeholder = "Search".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search"), style: .plain, target: self, action: #selector(addTapped))
        searchController.obscuresBackgroundDuringPresentation = false
        if #available(iOS 13.0, *) {
            searchController.showsSearchResultsController = false
            searchController.automaticallyShowsSearchResultsController = false
        } else {
            // Fallback on earlier versions
        }
//        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = .search
        searchBar.setValue("Cancel".localized(), forKey: "cancelButtonText")
        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.hidesBottomBarWhenPushed = true
        navigationItem.hidesSearchBarWhenScrolling = false
//        navigationItem.searchController = searchController
//        let view = UIView(frame: CGRect(x: -10, y: 0, width:200, height: 120))
//        view.addSubview(searchController.searchBar)
//        view.backgroundColor = .gray
//        navigationItem.searchController = nil
        searchBar.delegate = self
        
//        navigationItem.titleView = search
//        search.showsCancelButton = true
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.backgroundColor = .white
//        lastProd = SqlFile.takeAllProduct() ?? []
//        if lastProd.count == 0{
//        }
        let content = UIPasteboard.general.string ?? ""
        if let pref = UserDefaults(suiteName: suiteName){
            if pref.bool(forKey: "fromTrendyol"), let name = pref.string(forKey: "Name"){
                searchController.searchBar.text = name
                getProduct(url: searchController.searchBar.text)
                pref.removeObject(forKey: "fromTrendyol")
                pref.removeObject(forKey: "Name")
                pref.removeSuite(named: suiteName)
            }else if content.isValidURL && ((url ?? "") != content) {
                    url = content
                    getProduct(url: url)
            }else{
                getProducts()
            }
        }else{
            getProducts()
        }
//        }
    }
    
    func getProducts(){
        view.isUserInteractionEnabled = false
//        let wait = Components.shared.waitDialog(view: view)
        Network.shared.getProducts {[self] error in
            print(error)
            SVProgressHUD.dismiss()
//            wait.removeFromSuperview()
            showSkeleton = false
            view.isUserInteractionEnabled = true
            let error = Components.shared.getErrorDialog(message: error)
            present(error, animated: true)
        } success: {[self] cart in
//            SVProgressHUD.dismiss()
            showSkeleton = false
//            wait.removeFromSuperview()
            view.isUserInteractionEnabled = true
            guard let products = cart.products else {return}
//            products.forEach { product in
//                let product = Product(name: product.name, images: [Image(large: nil, medium: product.image)], brand: nil, in_stock: nil, price: product.price, sale_price: product.sale_price, slug: product.slug, storefrontId: nil, contentId: nil, url: product.url, sizes: nil, imageString: product.image, getProductUrl: product.url)
//                SqlFile.addProduct(product: product)
//            }
            lastProd = products
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    @objc func setUrl(){
//        let content = UIPasteboard.general.string
//        guard let content = content else { return }
        
//        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//        let matches = detector.matches(in: content, options: [], range: NSRange(location: 0, length: content.utf16.count))
//        for match in matches {
//            guard let range = Range(match.range, in: content) else { continue }
//            let url = content[range]
//            print(url)
//            break
//        }
//        if content.isValidURL && ((url ?? "") != content) {
//            url = content
//            getProduct(url: url)
//        }
//        
        if let pref = UserDefaults(suiteName: suiteName){
            if pref.bool(forKey: "fromTrendyol"), let name = pref.string(forKey: "Name"){
                searchController.searchBar.text = name
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    self.getProduct(url: name)
                }
                pref.removeObject(forKey: "fromTrendyol")
                pref.removeObject(forKey: "Name")
                pref.removeSuite(named: suiteName)
            }else{
                let content = UIPasteboard.general.string
                guard let content = content else { return }
                if content.isValidURL && ((url ?? "") != content) {
                    url = content
                    tabBarController?.selectedIndex = 1
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
                        self.getProduct(url: url)
                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
//                        self.getProduct(url: url)
//                    }
                }
            }
        }
//        if let pref = UserDefaults(suiteName: suiteName){
//            if let name = pref.string(forKey: "Name"){
//                let check = pref.bool(forKey: "fromTrendyol")
//                if check{
//                    searchController.searchBar.text = name
//                    getProduct(url: searchController.searchBar.text)
//                    pref.removeObject(forKey: "fromTrendyol")
//                    pref.removeObject(forKey: "Name")
//                }
//            }
//        }
    }
    
    
    
    @objc func addTapped(){
        if navigationItem.titleView != nil{
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search"), style: .plain, target: self, action: #selector(addTapped))
            navigationItem.titleView = nil
        }else{
            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchController.searchBar
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
    func showAuthVC(){
        let vc = LoginVC()
        let navBar = UINavigationController(rootViewController: vc)
        navBar.modalPresentationStyle = .formSheet
        present(navBar, animated: true)
    }
    
//    MARK: Search Controller Life Cycle -
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
        blackView.alpha = 0
        blackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blackView)
        NSLayoutConstraint.activate([
            blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blackView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
        UIView.animate(withDuration: 0.3) {[self] in
            blackView.alpha = 0.3
            blackView.backgroundColor = .black
        }
        blackView.isUserInteractionEnabled = true
        let rec = UITapGestureRecognizer(target: self, action: #selector(handleKeyboard))
        blackView.addGestureRecognizer(rec)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        UIView.animate(withDuration: 0.3) {[self] in
            blackView.alpha = 0
        } completion: {[self] _ in
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search"), style: .plain, target: self, action: #selector(addTapped))
            navigationItem.titleView = nil
            blackView.removeFromSuperview()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getProduct(url: searchBar.text)
    }
    
    func getProduct(url: String?){
//        mainView.collectionView.isSkeletonable = true
//        mainView.collectionView.showAnimatedGradientSkeleton()
        if lastUrl == (url ?? "--") {
            searchController.dismiss(animated: true) {
                UIView.animate(withDuration: 0.3) {[self] in
                    blackView.alpha = 0
                } completion: {[self] _ in
                    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search"), style: .plain, target: self, action: #selector(addTapped))
                    navigationItem.titleView = nil
                    blackView.removeFromSuperview()
                }
            }
            return
        }
        guard let url = url else { return }
        showSkeleton = true
        isProductShowed = true
        let size = Size(index: 1, origin_price: 100, barcode: nil, sale_price: 100, value: "XXL", inStock: 10, itemNumber: nil)
        let product = Product(name: "Sebedim product name", images: nil, brand: "Adidas", in_stock: nil, price: 100, sale_price: 100, slug: nil, storefrontId: nil, contentId: nil, url: url, sizes: [size, size, size, size], imageString: nil, getProductUrl: nil)
        self.product = product
        
        mainView.collectionView.isScrollEnabled = true
        mainView.collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
//        mainView.bottomView.isHidden = false
//        lastProd = SqlFile.takeAllProduct() ?? []
//        if lastProd.count == 0 {getProducts()}
        view.isUserInteractionEnabled = true
        handleKeyboard()
        self.product = product
        self.product?.getProductUrl = url
//        mainView.salePriceLb.text = "\((product.sale_price ?? 0).rounded(places: 2)) TMT"
//        mainView.addCartBtn.addTarget(self, action: #selector(addCartClicked), for: .touchUpInside)
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
        self.mainView.collectionView.performBatchUpdates {
            self.mainView.collectionView.reloadData()
        } completion: { _ in
            self.mainView.collectionView.reloadData()
        }
        self.mainView.collectionView.performBatchUpdates {
            self.mainView.collectionView.reloadData()
        } completion: { _ in
            self.mainView.collectionView.reloadData()
        }
//        }
//        self.product = nil
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {[ self ] in
            view.isUserInteractionEnabled = false
//            let wait = Components.shared.waitDialog(view: view)
            Network.shared.getProduct(product: url) {[self] error in
                print(error)
                SVProgressHUD.dismiss()
                showSkeleton = false
                view.isUserInteractionEnabled = true
//                wait.removeFromSuperview()
                let alert = UIAlertController(title: "Error".localized(), message: error, preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: {[self] _ in
                    lastUrl = ""
                    mainView.bottomView.isHidden = true
                    isProductShowed = false
                    self.product = nil
                    self.getProducts()
                })
    //            let errorDialog = Components.shared.getErrorDialog(message: error)
                let reload = UIAlertAction(title: "Reload".localized(), style: .default) {[self] _ in
                    getProduct(url: url)
                }
                alert.addAction(cancel)
                alert.addAction(reload)
    //            if error != "No token"{
                present(alert, animated: true, completion: nil)
    //            }else{
    //                showAuthVC()
    //            }
            } success: {[self] product in
                showSkeleton = false
                mainView.collectionView.isScrollEnabled = true
                mainView.collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
                mainView.bottomView.isHidden = false
                lastProd = SqlFile.takeAllProduct() ?? []
                if lastProd.count == 0 {getProducts()}
//                wait.removeFromSuperview()
                view.isUserInteractionEnabled = true
                SVProgressHUD.dismiss()
                handleKeyboard()
                lastUrl = url
                self.product = product
                self.product?.getProductUrl = url
                SqlFile.addProduct(product: self.product ?? product)
                mainView.salePriceLb.text = "\((product.sale_price ?? 0).rounded(places: 2)) TMT"
                mainView.addCartBtn.addTarget(self, action: #selector(addCartClicked), for: .touchUpInside)
                self.mainView.collectionView.performBatchUpdates {
                    self.mainView.collectionView.reloadData()
                } completion: { _ in
                    self.mainView.collectionView.reloadData()
                }
//                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
//                }
//                DispatchQueue.main.async {
//                }
                if let price = product.price{
                    mainView.priceLb.makeDiscount(price: "\((price))")
                }else{
                    mainView.priceLb.text = ""
                }
    //            guard let product = product else { return }
            }
        }
    }
    
    @objc func handleKeyboard(){
        searchController.dismiss(animated: true) {
            UIView.animate(withDuration: 0.3) {[self] in
                blackView.alpha = 0
            } completion: {[self] _ in
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search"), style: .plain, target: self, action: #selector(addTapped))
                navigationItem.titleView = nil
                blackView.removeFromSuperview()
            }
        }
    }
    
    @objc func addCartClicked(){
        guard let selectedSize = selectedSize else {
            let alert = UIAlertController(title: "Alert".localized(), message: "Please select size!".localized(), preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok".localized(), style: .default)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        guard let product = product else { return }
        let wait = Components.shared.waitDialog(view: view)
        Network.shared.addToCart(product: product, size: selectedSize) {[self] error in
            wait.removeFromSuperview()
            SVProgressHUD.dismiss()
            view.isUserInteractionEnabled = true
            print(error)
            if error == "No token"{
                showAuthVC()
            }else{
                let error = Components.shared.getErrorDialog(message: error)
                self.present(error, animated: true, completion: nil)
            }
        } success: { [self] in
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            wait.removeFromSuperview()
            SVProgressHUD.showSuccess(withStatus: "Product added".localized())
            DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
                SVProgressHUD.dismiss()
            }
        }
    }
    
//    MARK: -CollectionView Header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProductHeader", for: indexPath) as! ProductHeader
        header.backgroundColor = .white
//        mainView.headerHeight.isActive = true
        if showSkeleton{
            header.scrollView.contentSize = CGSize(width: scWidth, height: 350 * widthRatio)
            header.scrollView.subviews.forEach({$0.removeFromSuperview()})
            header.scrollView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault), animation: nil, transition: .crossDissolve(0.25))
            header.nameLb.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault), animation: nil, transition: .crossDissolve(0.25))
            header.trademakrLb.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault), animation: nil, transition: .crossDissolve(0.25))
        }else{
            guard let product = product else { return header }
            header.scrollView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            header.nameLb.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            header.trademakrLb.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            header.initData(product: product)
        }
        header.delegate = self
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(showImageViewerVC))
//        header.addGestureRecognizer(recognizer)
        return header
    }
    
    func imageClicked(index: Int?, smallImages: [UIImage]?) {
        guard let images = product?.images else { return }
        let vc = ImageViewerVC()
        vc.currentIndex = index ?? 0
        vc.images = images
        vc.modalPresentationStyle = .fullScreen
        vc.transitioningDelegate = self
        vc.interactor = interactor
        vc.smallImages = smallImages
        present(vc, animated: true, completion: nil)
    }
    
//    @objc func showImageViewerVC(){
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if product != nil{
            return CGSize(width:  scWidth, height: 420 * widthRatio)
        }else{
            return CGSize(width:  scWidth, height:0)
        }
    }
    
//    MARK: CollectionView CELL -
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
//            let sizeCount = product.sizes?.count ?? 0
    //        guard let sizeCount = productDetail.sizes?.count else {
    //            return CGSize(width: scWidth, height: 50*widthRatio)
    //        }
//            var sizeCountDiv = sizeCount / 5
//            let sizeCountMod = sizeCount % 5
//            if sizeCountMod != 0{sizeCountDiv += 1}
//            let calculate = CGFloat(sizeCountDiv) * widthRatio * CGFloat(60)
//            let height = calculate + (60*widthRatio)
            if product?.sizes?.count != 0 && product?.sizes?.count != nil{
                if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.sectionInset = UIEdgeInsets(top: 25, left: 0, bottom: 60, right: 0)
                    layout.estimatedItemSize = .zero
                    layout.minimumLineSpacing = 25
                }
                return CGSize(width: scWidth, height: 100)
            }else{
                if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    layout.estimatedItemSize = .zero
                    layout.minimumLineSpacing = 0
                }
                return CGSize(width: scWidth, height: 0)
            }
        }else{
            if lastProd.count != 0{
                if isProductShowed{
                    return CGSize(width: scWidth, height: (360*widthRatio))
                }else{
                    return CGSize(width: scWidth, height: (UIScreen.main.bounds.height-120))
                }
            }else{
//                return CGSize(width: scWidth, height: (UIScreen.main.bounds.height-120))
                if !showSkeleton {
                    return CGSize(width: scWidth, height: 0)
                }else{
                    return CGSize(width: scWidth, height: (UIScreen.main.bounds.height-120))
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSizeCell", for: indexPath) as! ProductSizeCell
            cell.sizes = product?.sizes
            cell.showSkeleton = showSkeleton
            cell.backgroundColor = .white
            cell.sizeSelected = { (size)  in
                self.sizeSelected(size: size)
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastProductsCell", for: indexPath) as! LastProductsCell
            cell.isVertical = !isProductShowed
            cell.showSkeleton = showSkeleton
            cell.products = lastProd
            cell.backgroundColor = .white
            cell.cellCallback = { [weak self] (row) in
                if let attributes = collectionView.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) {
                    collectionView.setContentOffset(CGPoint(x: 0, y: attributes.frame.origin.y - collectionView.contentInset.top), animated: true)
                }
                self?.searchController.searchBar.text = self?.lastProd[row].url
//                self?.lastProd.removeAll()
                self?.getProduct(url: self?.lastProd[row].url)
                self?.selectedSize = nil
            }
            return cell
        }
    }
    
    func sizeSelected(size: Size){
        selectedSize = size
        mainView.salePriceLb.text = "\(size.sale_price ?? 0) TMT"
    }
}

// MARK: Close VC SLide Down -
extension ProductVC: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       DismissAnimator()
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
       interactor.hasStarted ? interactor : .none
    }
}


// MARK: Skeleton Collection-
extension ProductVC: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource{

    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
        cell.isSkeletonable = true
        cell.showAnimatedGradientSkeleton()
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        return "ProductHeader"
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "ProductSizeCell"
    }
}
