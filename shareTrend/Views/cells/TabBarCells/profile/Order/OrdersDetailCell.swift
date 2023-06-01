//
//  OrdersDetailCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 10.05.2022.
//

import UIKit


class OrdersDetailHeader: UICollectionReusableView {
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xFAFAFA)
        return view
    }()
    
    let orderIdKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 12)
        return lb
    }()
    
    let orderDateKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 12)
        return lb
    }()
    
    let orderCountKeyLb: UILabel = {
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
    
    let orderDateValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        return lb
    }()
    
    let orderCountValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        return lb
    }()
    
    let statusImgView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let statusLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        cardView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(cardView)
        cardView.addSubview(orderIdKeyLb)
        cardView.addSubview(orderIdValueLb)
        cardView.addSubview(orderDateKeyLb)
        cardView.addSubview(orderDateValueLb)
        cardView.addSubview(orderCountKeyLb)
        cardView.addSubview(orderCountValueLb)
        cardView.addSubview(statusImgView)
        cardView.addSubview(statusLb)
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(rgb: 0xEBEBEB).cgColor
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            orderIdKeyLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            orderIdKeyLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            orderIdValueLb.leadingAnchor.constraint(equalTo: orderIdKeyLb.trailingAnchor, constant: 5),
            orderIdValueLb.centerYAnchor.constraint(equalTo: orderIdKeyLb.centerYAnchor),
            
            orderDateKeyLb.leadingAnchor.constraint(equalTo: orderIdKeyLb.leadingAnchor),
            orderDateKeyLb.topAnchor.constraint(equalTo: orderIdKeyLb.bottomAnchor, constant: 10),
            orderDateValueLb.leadingAnchor.constraint(equalTo: orderDateKeyLb.trailingAnchor, constant: 5),
            orderDateValueLb.centerYAnchor.constraint(equalTo: orderDateKeyLb.centerYAnchor),
            
            orderCountKeyLb.leadingAnchor.constraint(equalTo: orderIdKeyLb.leadingAnchor),
            orderCountKeyLb.topAnchor.constraint(equalTo: orderDateKeyLb.bottomAnchor, constant: 10),
            orderCountValueLb.leadingAnchor.constraint(equalTo: orderCountKeyLb.trailingAnchor, constant: 5),
            orderCountValueLb.centerYAnchor.constraint(equalTo: orderCountKeyLb.centerYAnchor),
            
            statusImgView.leadingAnchor.constraint(equalTo: orderIdKeyLb.leadingAnchor),
            statusImgView.topAnchor.constraint(equalTo: orderCountKeyLb.bottomAnchor, constant: 10),
            statusLb.leadingAnchor.constraint(equalTo: statusImgView.trailingAnchor, constant: 7),
            statusLb.centerYAnchor.constraint(equalTo: statusImgView.centerYAnchor),
        ])
        
        orderCountKeyLb.text = "Haryt sany:".localized()
        orderCountValueLb.text = "3 sany"
        orderIdKeyLb.text = "Zakaz kody:".localized()
        orderIdValueLb.text = "#532536"
        orderDateKeyLb.text = "Zakazyň berilen wagty:".localized()
        orderDateValueLb.text = "23 Aprel - 19:40"
        statusImgView.image = UIImage(named: "tick-circle")
        statusLb.text = "Garaşylýar".localized()
    }
    
    func initData(order: Order){
        statusLb.text = "\(order.status ?? "No status")".localized()
        orderIdValueLb.text = "#\(order.order_id?.stringValue ?? "")"
        let isoDate = (order.created_at ?? "2021-12-14T05:04:13")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        let date = dateFormatter.date(from:isoDate) ?? Date()
        let formDate = DateFormatter()
        formDate.dateFormat = "dd MMM yyyy - HH:mm"
        let uploadCreate = formDate.string(from: date)
        orderDateValueLb.text = uploadCreate
        orderCountValueLb.text = "\(order.products?.count ?? 0)"
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
        case "delivered":
            statusImgView.image = UIImage(named: "tick-circle")
            statusLb.textColor = UIColor(rgb: 0x23B073)
        default:
            statusImgView.image = UIImage(named: "close-circle")
            statusLb.textColor = UIColor(rgb: 0xFF5A5A)
        }
    }
}

class OrdersDetailCell: UICollectionViewCell {
    var cancelCallback: (()->())?
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let nameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return lb
    }()
    
    let descLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return lb
    }()
    
    let sizeKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return lb
    }()
    
    let sizeValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return lb
    }()
        
    let countKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return lb
    }()
    
    let countValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return lb
    }()
    
    let discountLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 10)
        lb.textColor = UIColor(rgb: 0x909090)
        return lb
    }()
    
    let priceLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 12)
        return lb
    }()
    
    let canceltBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "close-square"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        cardView.layer.borderColor = UIColor.passiveColor.cgColor
        cardView.layer.borderWidth = 0.5
        cardView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.passiveColor.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        contentView.addSubview(cardView)
        cardView.addSubview(imageView)
        cardView.addSubview(nameLb)
        cardView.addSubview(descLb)
        cardView.addSubview(sizeKeyLb)
        cardView.addSubview(sizeValueLb)
        cardView.addSubview(countKeyLb)
        cardView.addSubview(countValueLb)
        cardView.addSubview(discountLb)
        cardView.addSubview(priceLb)
//        cardView.addSubview(acceptBtn)
        cardView.addSubview(canceltBtn)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            imageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 90*widthRatio),
            imageView.heightAnchor.constraint(equalToConstant: 105*widthRatio),
            
            nameLb.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            nameLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            nameLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            
            descLb.topAnchor.constraint(equalTo: nameLb.bottomAnchor, constant: 3),
            descLb.leadingAnchor.constraint(equalTo: nameLb.leadingAnchor),
            descLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            
            sizeKeyLb.leadingAnchor.constraint(equalTo: nameLb.leadingAnchor),
            sizeKeyLb.topAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 3),
            sizeValueLb.leadingAnchor.constraint(equalTo: sizeKeyLb.trailingAnchor, constant: 5),
            sizeValueLb.centerYAnchor.constraint(equalTo: sizeKeyLb.centerYAnchor),
            
            countKeyLb.leadingAnchor.constraint(equalTo: nameLb.leadingAnchor),
            countKeyLb.topAnchor.constraint(equalTo: sizeKeyLb.bottomAnchor, constant: 3),
            countValueLb.leadingAnchor.constraint(equalTo: countKeyLb.trailingAnchor, constant: 5),
            countValueLb.centerYAnchor.constraint(equalTo: countKeyLb.centerYAnchor),
            discountLb.leadingAnchor.constraint(equalTo: nameLb.leadingAnchor),
            discountLb.topAnchor.constraint(equalTo: countKeyLb.bottomAnchor, constant: 3),
            priceLb.leadingAnchor.constraint(equalTo: nameLb.leadingAnchor),
            priceLb.topAnchor.constraint(equalTo: discountLb.bottomAnchor),
            
            canceltBtn.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            canceltBtn.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -15),
//            canceltBtn.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
//            canceltBtn.trailingAnchor.constraint(equalTo: acceptBtn.leadingAnchor, constant: -24),
        ])
//        acceptBtn.setImage(UIImage(named: "tick-square"), for: .normal)
        discountLb.isHidden = true
        discountLb.text = "1224 TMT"
        priceLb.text = "974.20TMT"
        countKeyLb.text = "Sany:".localized()
        countValueLb.text = "1"
        sizeKeyLb.text = "Razmer:".localized()
        sizeValueLb.text = "41"
        nameLb.text = "Advanced Trainer"
        nameLb.numberOfLines = 2
//        descLb.text = "Hakiki Deri Siyah Kadın Topuklu.."
        imageView.image = UIImage(named: "cardimage")
    }
    
    func initData(_ product: OrderProduct){
        countValueLb.text = "\(product.count ?? 0)"
        canceltBtn.isUserInteractionEnabled = true
        canceltBtn.addTarget(self, action: #selector(clickCancel), for: .touchUpInside)
        priceLb.text = "\(product.price ?? 0) TMT"
        imageView.sdImageLoad(imgUrl: product.image ?? "", placeholder: true, placImg: nil)
        nameLb.text = product.name
        canceltBtn.tintColor = .error
        sizeValueLb.text = product.size ?? ""
    }
    
    @objc func clickCancel(){
        cancelCallback?()
        print("Cancelll!!")
        
    }
    
}

class OrdersCancelCell: UICollectionViewCell {
    let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        btn.setTitle("Cancel".localized(), for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 14)
        return btn
    }()
    
    var cancelCallback: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        contentView.addSubview(cancelBtn)
        cancelBtn.addTarget(self, action: #selector(clickCancel), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cancelBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            cancelBtn.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15),
        ])
        cancelBtn.layer.borderColor = UIColor.red.cgColor
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.cornerRadius = 5
    }
    
    @objc func clickCancel(){
        cancelCallback?()
    }
}

class OrdersDetailFooter: UICollectionReusableView {
    
    let paymentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.passiveColor.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let paymentHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xFAFAFA)
        view.layer.borderColor = UIColor.passiveColor.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let tolegLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Bold", size: 14)
        return label
    }()
    
    let whatPayment: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return label
    }()
    let allProductPriceKeyLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    let allProductPriceValueLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    let deliveriPriceKeyLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    let deliveriPriceValueLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    let discountsKeyLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    let discountsValueLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return label
    }()
    let allPriceKey: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Bold", size: 14)
        return label
    }()
    let allPriceValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Bold", size: 14)
        return label
    }()
    let line1: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .passiveColor
        return line
    }()
    let line2: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .passiveColor
        return line
    }()
//    let line3: UIView = {
//        let line = UIView()
//        line.translatesAutoresizingMaskIntoConstraints = false
//        line.backgroundColor = .passiveColor
//        return line
//    }()
//    let line4: UIView = {
//        let line = UIView()
//        line.translatesAutoresizingMaskIntoConstraints = false
//        line.backgroundColor = .passiveColor
//        return line
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        decorate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(paymentView)
        paymentView.addSubview(paymentHeader)
        paymentHeader.addSubview(tolegLb)
        paymentHeader.addSubview(whatPayment)
        paymentView.addSubview(allProductPriceKeyLb)
        paymentView.addSubview(allProductPriceValueLb)
        paymentView.addSubview(line1)
        paymentView.addSubview(line2)
        paymentView.addSubview(deliveriPriceKeyLb)
        paymentView.addSubview(deliveriPriceValueLb)
        paymentView.addSubview(discountsKeyLb)
        paymentView.addSubview(discountsValueLb)
        paymentView.addSubview(allPriceKey)
        paymentView.addSubview(allPriceValue)
        
//        paymentView.addSubview(line3)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            paymentView.topAnchor.constraint(equalTo: topAnchor, constant: 20 * widthRatio),
            paymentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            paymentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            paymentView.heightAnchor.constraint(equalToConstant: 252 * widthRatio),
            
            paymentHeader.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor),
            paymentHeader.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor),
            paymentHeader.topAnchor.constraint(equalTo: paymentView.topAnchor),
            paymentHeader.heightAnchor.constraint(equalToConstant: 55 * widthRatio),
            
            tolegLb.leadingAnchor.constraint(equalTo: paymentHeader.leadingAnchor, constant: 16),
            tolegLb.centerYAnchor.constraint(equalTo: paymentHeader.centerYAnchor),
            
            whatPayment.trailingAnchor.constraint(equalTo: paymentHeader.trailingAnchor, constant: -16),
            whatPayment.centerYAnchor.constraint(equalTo: paymentHeader.centerYAnchor),
            
            allProductPriceKeyLb.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16),
            allProductPriceKeyLb.topAnchor.constraint(equalTo: paymentHeader.bottomAnchor, constant: 27),
            
            allProductPriceValueLb.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -16),
            allProductPriceValueLb.centerYAnchor.constraint(equalTo: allProductPriceKeyLb.centerYAnchor),
            
            line1.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16),
            line1.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -16),
            line1.heightAnchor.constraint(equalToConstant: 1),
            line1.topAnchor.constraint(equalTo: allProductPriceKeyLb.bottomAnchor, constant: 11  * widthRatio),
            
            deliveriPriceKeyLb.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16),
            deliveriPriceKeyLb.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 13 * widthRatio),
            
            deliveriPriceValueLb.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -16),
            deliveriPriceValueLb.centerYAnchor.constraint(equalTo: deliveriPriceKeyLb.centerYAnchor),
            
            line2.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16),
            line2.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -16),
            line2.heightAnchor.constraint(equalToConstant: 1),
            line2.topAnchor.constraint(equalTo: deliveriPriceKeyLb.bottomAnchor, constant: 11 * widthRatio),
            
            discountsKeyLb.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16),
            discountsKeyLb.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 13  * widthRatio),
            
            discountsValueLb.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -16),
            discountsValueLb.centerYAnchor.constraint(equalTo: discountsKeyLb.centerYAnchor),
            
//            line3.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16),
//            line3.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -16),
//            line3.heightAnchor.constraint(equalToConstant: 1),
//            line3.topAnchor.constraint(equalTo: discountsKeyLb.bottomAnchor, constant: 11  * widthRatio),
            
            allPriceKey.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 16  * widthRatio),
            allPriceKey.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 13),
            allPriceValue.trailingAnchor.constraint(equalTo: paymentView.trailingAnchor, constant: -16),
            allPriceValue.centerYAnchor.constraint(equalTo: allPriceKey.centerYAnchor),
            paymentView.bottomAnchor.constraint(equalTo: allPriceKey.bottomAnchor, constant: 16),
        ])
    }
    
    private func decorate(){
        paymentView.layer.cornerRadius = 8
        paymentHeader.layer.cornerRadius = 8
    }
    
    func initData(order: Order){
        tolegLb.text = "Töleg".localized()
        allProductPriceKeyLb.text = "Harytlaryň jemi bahasy :".localized()
        allProductPriceValueLb.text = "\(order.total ?? 0) TMT"
        deliveriPriceKeyLb.text = "Eltip bermek hyzmaty :".localized()
//        if order.payment_method == 1{
//            whatPayment.text = "Nagt toleg"
//        }else{
//            whatPayment.text = "Terminal"
//        }
        let allPrice = (order.total ?? 0) + (order.shipping_price ?? 0)
        allPriceValue.text = "\(allPrice.rounded(places: 2)) TMT"
        deliveriPriceValueLb.text = "\(order.shipping_price ?? 0) TMT"
        allPriceKey.text = "JEMI BAHASY :".localized()
        
    }
    
}
