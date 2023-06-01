//
//  ProfileOrdersCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 10.05.2022.
//

import UIKit

class ProfileOrdersListCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    var userOrder: UserOrder!{
//        didSet{
//            initCollection()
//        }
//    }
    let headerView: UIView = {
        let header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        return header
    }()
    let dateLB: UILabel = {
        let date = UILabel()
        date.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        date.textColor = .black
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    let priceTextLb: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.font = UIFont(name: "ProximaNova-Regular", size: 12)
        return price
    }()
    let priceLb: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        return price
    }()
    let dolyMagLb: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Bold", size: 12)
        label.textColor = .borderColor
        return label
    }()
    let likeImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    let statusLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return label
    }()
    let proCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        label.textColor = .borderColor
        return label
    }()
    let proCountKey: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        label.textColor = .borderColor
        return label
    }()
    let priceValue: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        return price
    }()
    var myCollectionView: UICollectionView?
    
    override func awakeFromNib() {
        initView()
    }
    
    func initView(){
        layer.borderWidth = 1
        layer.borderColor = UIColor.mainColor.cgColor
        
        headerView.layer.borderColor = UIColor.mainColor.cgColor
        headerView.layer.borderWidth = 1
        contentView.addSubview(headerView)
        contentView.addSubview(likeImg)
        contentView.addSubview(statusLb)
        contentView.addSubview(proCount)
        contentView.addSubview(proCountKey)
        headerView.addSubview(dateLB)
        headerView.addSubview(priceTextLb)
        headerView.addSubview(dolyMagLb)
        headerView.addSubview(priceLb)
        headerView.addSubview(priceValue)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 55 * widthRatio),
            
            dolyMagLb.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -14),
            dolyMagLb.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            dateLB.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            dateLB.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12),
            dateLB.trailingAnchor.constraint(equalTo: dolyMagLb.leadingAnchor, constant: -5),
            
            priceTextLb.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            priceTextLb.topAnchor.constraint(equalTo: dateLB.bottomAnchor, constant: 8 * widthRatio),
            
            priceLb.leadingAnchor.constraint(equalTo: priceTextLb.trailingAnchor, constant: 3),
            priceLb.centerYAnchor.constraint(equalTo: priceTextLb.centerYAnchor),
            
            priceValue.leadingAnchor.constraint(equalTo: priceLb.trailingAnchor),
            priceValue.centerYAnchor.constraint(equalTo: priceLb.centerYAnchor),
//            priceLb.trailingAnchor.constraint(equalTo: dolyMagLb.leadingAnchor, constant: 5),
            
            likeImg.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            likeImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            likeImg.heightAnchor.constraint(equalToConstant: 12 * widthRatio),
            likeImg.widthAnchor.constraint(equalToConstant: 12 * widthRatio),
            
            statusLb.leadingAnchor.constraint(equalTo: likeImg.trailingAnchor, constant: 10),
            statusLb.centerYAnchor.constraint(equalTo: likeImg.centerYAnchor),
            statusLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            
            proCount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            proCount.topAnchor.constraint(equalTo: statusLb.bottomAnchor, constant: 84),
            
            proCountKey.leadingAnchor.constraint(equalTo: proCount.trailingAnchor, constant: 2),
            proCountKey.centerYAnchor.constraint(equalTo: proCount.centerYAnchor)
//            proCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
        ])

        statusLb.text = "Order Status".localized()
        dolyMagLb.text = "Order Status".localized()
        dateLB.text = "23 Aprel - 19:40"
        
    }
    
//    func initData(){
//        proCount.text = String(userOrder.products?.count ?? 0)
//        proCountKey.text = "sany haryt"
//        priceLb.text = "JEMI BAHASY :"
//        let total = userOrder.total?.rounded(places: 2)
//        priceValue.text = String(total ?? 0) + "TMT"
//        statusLb.text = userOrder.status?.localized()
//        userOrder.created_at?.removeLast(5)
//        let isoDate = (userOrder.created_at ?? "2021-12-14T05:04:13")
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        let date = dateFormatter.date(from:isoDate) ?? Date()
//        let formDate = DateFormatter()
//        formDate.dateFormat = "dd MMM yyyy - HH:mm"
//        let uploadCreate = formDate.string(from: date)
//        dateLB.text = uploadCreate
//        likeImg.tintColor = .black
//        switch userOrder.status {
//        case "pending":
//            likeImg.image = UIImage(named: "clock-1")
//        case "accepted":
//            likeImg.image = UIImage(named: "thumbs-up")
//        case "in_truck":
//            likeImg.image = UIImage(named: "thumbs-up")
//        case "in_stock":
//            likeImg.image = UIImage(named: "thumbs-up")
//        case "packing":
//            likeImg.image = UIImage(named: "thumbs-up")
//        case "stock_tm":
//            likeImg.image = UIImage(named: "thumbs-up")
//        case "stock_tr":
//            likeImg.image = UIImage(named: "thumbs-up")
//        case "ontheway":
//            likeImg.image = UIImage(named: "truck-1")
//        case "received":
//            likeImg.image = UIImage(named: "check-square-1")
//        case "canceled":
//            likeImg.image = UIImage(named: "cancel")
//        case "rejected":
//            likeImg.image = UIImage(named: "cancel")
//        case "returned":
//            likeImg.image = UIImage(named: "cancel")
//        default:
//            likeImg.image = UIImage(named: "clock-1")
//        }
//    }
    
    func initCollection(){
        if myCollectionView == nil{
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            layout.scrollDirection = .horizontal
            isUserInteractionEnabled = true
            myCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
            myCollectionView?.register(ProfileOrdersMiniListCell.self, forCellWithReuseIdentifier: "ProfileOrdersMiniListCell")
            myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
            myCollectionView?.backgroundColor = UIColor.white
            myCollectionView?.dataSource = self
            myCollectionView?.delegate = self
            myCollectionView?.isUserInteractionEnabled = true
            myCollectionView?.isScrollEnabled = true
            myCollectionView?.isUserInteractionEnabled = true
            myCollectionView?.showsHorizontalScrollIndicator = false
            myCollectionView?.delegate = self
            myCollectionView?.dataSource = self
            contentView.addSubview(myCollectionView!)
            NSLayoutConstraint.activate([
                myCollectionView!.leadingAnchor.constraint(equalTo: leadingAnchor),
                myCollectionView!.trailingAnchor.constraint(equalTo: trailingAnchor),
                myCollectionView!.topAnchor.constraint(equalTo: statusLb.bottomAnchor, constant: 9),
                myCollectionView!.heightAnchor.constraint(equalToConstant: 64 * widthRatio)
            ])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 46 * widthRatio, height: 63 * widthRatio)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileOrdersMiniListCell", for: indexPath) as! ProfileOrdersMiniListCell
        cell.imgView.image = #imageLiteral(resourceName: "cardimage")
//        let url = Network.IMAGE_URL + (userOrder.products?[indexPath.row].image ?? "")
//        cell.imgView.loadImageUsingUrlString(urlString: url) {}
        return cell
    }
}


class ProfileOrdersMiniListCell: UICollectionViewCell{
    let imgView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
//    override func awakeFromNib() {
//
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    func initView(){
        addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imgView.topAnchor.constraint(equalTo: topAnchor),
            imgView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        imgView.layer.borderColor = UIColor.mainColor.cgColor
        imgView.layer.borderWidth = 1
        imgView.image = #imageLiteral(resourceName: "cardimage")
    }
    
}
