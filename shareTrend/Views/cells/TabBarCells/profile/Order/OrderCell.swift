//
//  OrderCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 10.05.2022.
//

import UIKit

class OrderCell: UICollectionViewCell {
    
    var products: [OrderProduct] = []{
        didSet{
            DispatchQueue.main.async {[self] in
                collectionView.reloadData()
            }
        }
    }
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor(rgb: 0xEBEBEB).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
//    MARK: HeaderView-
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xFAFAFA)
        view.layer.borderColor = UIColor(rgb: 0xEBEBEB).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let orderIdKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 12)
        return lb
    }()
    
    let allPriceKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 12)
        return lb
    }()
    
    let orderIdValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        return lb
    }()
    
    let allPriceValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        return lb
    }()
    
    let detailBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .mainColor
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Doly maglumat".localized(), for: .normal)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 12)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        return btn
    }()
    
    let dateLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        lb.textColor = UIColor(rgb: 0x909090)
        return lb
    }()
    
    let statusLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        lb.textColor = UIColor(rgb: 0x23B073)
        return lb
    }()
    
    let statusImgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "tick-circle")
        return img
    }()
    
//    MARK: CollectionView-
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(MiniOrderCell.self, forCellWithReuseIdentifier: "MiniOrderCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        decorateViews()
    }
    
    override func prepareForReuse() {
        products = []
    }
    
    private func setupViews(){
        contentView.addSubview(cardView)
        cardView.addSubview(headerView)
        headerView.addSubview(orderIdKeyLb)
        headerView.addSubview(orderIdValueLb)
        headerView.addSubview(allPriceKeyLb)
        headerView.addSubview(allPriceValueLb)
        headerView.addSubview(detailBtn)
        cardView.addSubview(collectionView)
        cardView.addSubview(dateLb)
        cardView.addSubview(statusLb)
        cardView.addSubview(statusImgView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 55 * widthRatio),
            
            orderIdKeyLb.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            orderIdKeyLb.bottomAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -3),
            orderIdValueLb.leadingAnchor.constraint(equalTo: orderIdKeyLb.trailingAnchor, constant: 5),
            orderIdValueLb.centerYAnchor.constraint(equalTo: orderIdKeyLb.centerYAnchor),
            
            allPriceKeyLb.leadingAnchor.constraint(equalTo: orderIdKeyLb.leadingAnchor),
            allPriceKeyLb.topAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 3),
            allPriceValueLb.leadingAnchor.constraint(equalTo: allPriceKeyLb.trailingAnchor, constant: 5),
            allPriceValueLb.centerYAnchor.constraint(equalTo: allPriceKeyLb.centerYAnchor),
            
            detailBtn.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -9),
            detailBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -37),
            
            dateLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            dateLb.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -11),
            
            statusImgView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            statusImgView.centerYAnchor.constraint(equalTo: dateLb.centerYAnchor),
            statusLb.trailingAnchor.constraint(equalTo: statusImgView.leadingAnchor, constant: -7),
            statusLb.centerYAnchor.constraint(equalTo: dateLb.centerYAnchor),
            
        ])
        
        orderIdKeyLb.text = "Sargyt ID:".localized()
        orderIdValueLb.text = "#IA125788"
        allPriceKeyLb.text = "Jemi Bahasy:".localized()
        allPriceValueLb.text = "9421 TMT"
        dateLb.text = "23 Aprel - 19:40"
    }
    
    private func decorateViews(){
        cardView.layer.cornerRadius = 8
        headerView.layer.cornerRadius = 8
        detailBtn.layer.cornerRadius = 8
    }
    
    func initData(order: Order){
        statusLb.text = (order.status ?? "").localized()
        orderIdValueLb.text = "#\(order.order_id?.stringValue ?? "")"
        allPriceValueLb.text = "\((order.total ?? 0).rounded(places: 2)) TMT"
        let isoDate = (order.created_at ?? "2021-12-14T05:04:13")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        let date = dateFormatter.date(from:isoDate) ?? Date()
        let formDate = DateFormatter()
        formDate.dateFormat = "dd MMM yyyy - HH:mm"
        let uploadCreate = formDate.string(from: date)
        dateLb.text = uploadCreate
        switch order.status {
        case "pending":
            statusImgView.image = UIImage(named: "clock")
            statusLb.textColor = UIColor(rgb: 0x909090)
        case "accepted":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        case "ordered":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        case "in_office":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        case "delivered":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        case "in_truck":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        case "in_stock":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        case "packing":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        case "stock_tm":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        case "stock_tr":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        case "ontheway":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        case "received":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        default:
            statusImgView.image = UIImage(named: "close-circle")
            statusLb.textColor = UIColor(rgb: 0xFF5A5A)
        }
    }
}

extension OrderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 47, height: 63)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniOrderCell", for: indexPath) as! MiniOrderCell
        cell.setupData(product: products[indexPath.row])
        return cell
    }
}
