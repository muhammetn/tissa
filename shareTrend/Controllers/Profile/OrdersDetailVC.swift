//
//  OrdersDetailVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 10.05.2022.
//

import UIKit
import SVProgressHUD

class OrdersDetailVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
//    MARK: Varables -
    
    var products = [OrderProduct]()
    var orderId = String()
    var orderDetail: Order?
    
//    MARK: VC's Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
    }
    
//    MARK: Custom funcs -
    
    private func setup(){
        collectionView.backgroundColor = .white
        collectionView.register(OrdersDetailCell.self, forCellWithReuseIdentifier: "OrdersDetailCell")
        collectionView.register(OrdersCancelCell.self, forCellWithReuseIdentifier: "OrdersCancelCell")
        collectionView.register(OrdersDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "OrdersDetailHeader")
        collectionView.register(OrdersDetailFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "OrdersDetailFooter")
    }
    
    private func loadData(){
        let waite = Components.shared.waitDialog(view: view)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {[self] in 
            Network.shared.getOrder(orderId: orderId) {[self] error in
                print(error)
                waite.removeFromSuperview()
                view.isUserInteractionEnabled = true
                SVProgressHUD.dismiss()
                let errorDialog = Components.shared.getErrorDialog(message: error)
                present(errorDialog, animated: true, completion: nil)
            } success: {[self] result in
                waite.removeFromSuperview()
                view.isUserInteractionEnabled = true
                SVProgressHUD.dismiss()
                orderDetail = result.body
                products.append(contentsOf: result.body?.products ?? [])
                collectionView.reloadData()
            }
        }
    }
    
//    MARK: Collection Cells -
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == products.count{
            return CGSize(width: scWidth-32, height: 50)
        }else{
            return CGSize(width: scWidth-32, height: 130 * widthRatio)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count+1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != products.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrdersDetailCell", for: indexPath) as! OrdersDetailCell
            if indexPath.row == 0{
                cell.cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }else if indexPath.row == products.count-1{
                cell.cardView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }else{
                cell.cardView.layer.maskedCorners = []
            }
            cell.initData(products[indexPath.row])
            guard let status = products[indexPath.row].status else { return cell }
            if status == "canceled" || status == "rejected"{
                cell.canceltBtn.isHidden = true
            }else{
                cell.canceltBtn.isHidden = false
            }
            cell.cancelCallback = {[weak self] in
                let alert = UIAlertController(title: "Cancel order".localized(), message: "Are you sure?".localized(), preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok".localized(), style: .default) { _ in
                    self?.cancelOrder(od_id: self?.products[indexPath.row].od_id?.stringValue ?? "", index: indexPath)
                }
                let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel)
                alert.addAction(action)
                alert.addAction(cancel)
                self?.present(alert, animated: true, completion: nil)
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrdersCancelCell", for: indexPath) as! OrdersCancelCell
            guard let status = orderDetail?.status else {return cell}
            if status == "canceled" || status == "rejected"{
                cell.cancelBtn.isHidden = true
            }else{
                cell.cancelBtn.isHidden = false
                cell.cancelCallback = {[weak self] in
                    let alert = UIAlertController(title: "Cancel order".localized(), message: "Are you sure?".localized(), preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok".localized(), style: .default) { _ in
                        self?.cancelAllProducts(order_id: (self?.orderId ?? ""))
                    }
                    let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel)
                    alert.addAction(action)
                    alert.addAction(cancel)
                    self?.present(alert, animated: true, completion: nil)
                }
            }
            return cell
        }
    }
    
//    MARK: Header & Footer -
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: scWidth, height: 238)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: scWidth, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OrdersDetailHeader", for: indexPath) as! OrdersDetailHeader
            header.initData(order: orderDetail ?? Order())
            return header
        }else {
            let foorter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OrdersDetailFooter", for: indexPath) as! OrdersDetailFooter
            foorter.initData(order: orderDetail ?? Order())
            return foorter
        }
    }
    
    
    func cancelAllProducts(order_id: String){
        let waite = Components.shared.waitDialog(view: view)
        Network.shared.cancelOrders(order_id: order_id) {[self] error in
            print(error)
            waite.removeFromSuperview()
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            let errorDialog = Components.shared.getErrorDialog(message: error)
            present(errorDialog, animated: true, completion: nil)
        } success: {[self] in
            waite.removeFromSuperview()
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            for i in products.indices {
                products[i].status = "canceled"
            }
            orderDetail?.status = "canceled"
            collectionView.reloadData()
        }
    }
    
    func cancelOrder(od_id: String, index: IndexPath){
        let waite = Components.shared.waitDialog(view: view)
        Network.shared.cancelOrder(od_id: od_id) { [self] error in
            print(error)
            waite.removeFromSuperview()
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            let errorDialog = Components.shared.getErrorDialog(message: error)
            present(errorDialog, animated: true, completion: nil)
        } success: {[self] in
            waite.removeFromSuperview()
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            products[index.row].status = "canceled"
            collectionView.reloadData()
        }
    }
}
