//
//  OrdersVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 10.05.2022.
//

import UIKit
import SVProgressHUD

class OrdersVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
//    MARK: Variables-
    lazy var orders = [Order]()
    lazy var products = [[OrderProduct]]()
    var load = true
    var wait = UIView()
    var page = 1
    
//    MARK: Override Funcs -
    override func viewDidLoad() {
        super.viewDidLoad()
        wait = Components.shared.waitDialog(view: view)
        setupUI()
    }
    
//    MARK: Custom Funcs -
    func setupUI(){
        navigationItem.title = "Orders".localized()
        collectionView.backgroundColor = .white
        collectionView.register(OrderCell.self, forCellWithReuseIdentifier: "OrderCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        orders = []
        products = []
        load = true
        page = 1
        loadData()
    }
    
    private func loadData(){
        if !load { return }
        Network.shared.getOrders(page: page) {[self] error in
            print(error)
            SVProgressHUD.dismiss()
            view.isUserInteractionEnabled = true
            wait.removeFromSuperview()
            let errorDialog = Components.shared.getErrorDialog(message: error)
            present(errorDialog, animated: true, completion: nil)
        } success: { [self] result in
            SVProgressHUD.dismiss()
            view.isUserInteractionEnabled = true
            wait.removeFromSuperview()
            guard let orders = result.body else { return }
            if orders.count < 10{ load = false}
            self.orders.append(contentsOf: orders)
            guard let ords = result.body else { return }
            for ord in ords{
                products.append(ord.products ?? [])
            }
            collectionView.reloadData()
        }
    }
    
//    MARK: CollectionView Funcs -
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: scWidth-32, height: 171*widthRatio)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        orders.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as! OrderCell
        DispatchQueue.main.async { [self] in
            cell.detailBtn.tag = Int(orders[indexPath.row].order_id?.stringValue ?? "") ?? 0
            cell.detailBtn.addTarget(self, action: #selector(clickDetail(_:)), for: .touchUpInside)
            cell.initData(order: orders[indexPath.row])
            cell.products = products[indexPath.row]
        }
        if indexPath.row == orders.count { page += 1; loadData() }
        return cell
    }
    
//    MARK: Action Funcs -
    
    @objc func clickDetail(_ sender: UIButton){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layout.estimatedItemSize = .zero
        layout.minimumLineSpacing = 0
        let vc = OrdersDetailVC(collectionViewLayout: layout)
        vc.orderId = String(sender.tag)
        show(vc, sender: self)
    }
    
}
