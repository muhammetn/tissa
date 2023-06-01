//
//  CartCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 28.04.2022.
//

import UIKit
import FittedSheets
import MBCheckboxButton

class CartCell: UITableViewCell {
    
    var removeCallback: (()->())?
    var countCallback: (()->())?
    var checkBtnCallback: (()->())?
    var sizeCallback: (()->())?
    
    let productImgView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.borderColor.cgColor
        return image
    }()
    
    let nameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 13)
        lb.numberOfLines = 2
        return lb
    }()
    
    let sizeKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        return lb
    }()
    
    let sizeValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 12)
        return lb
    }()
    
    let idKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 11)
        return lb
    }()
    
    let idValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 11)
        return lb
    }()
    
    let priceLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 13)
        return lb
    }()
    
    let discountLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 13)
        lb.textColor = .gray
        return lb
    }()
    
    let countBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        btn.layer.borderColor = UIColor.borderColor.cgColor
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        btn.setTitleColor(.gray, for: .normal)
        btn.layer.borderWidth = 1
        return btn
    }()
    
    let removeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "trash"), for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        btn.tintColor = .black
        return btn
    }()
    
    var checkBoxBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "checkbox-unchecked"), for: .normal)
        return btn
    }()
    
    let hiddenCheckBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        return btn
    }()
    
    let sizeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 12)
        btn.layer.borderColor = UIColor.borderColor.cgColor
        btn.titleLabel?.textColor = .black
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        btn.setTitleColor(.gray, for: .normal)
        btn.layer.borderWidth = 1
        return btn
    }()
    
    let idStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 5
        view.axis = .horizontal
        return view
    }()
    
    let pickerContainerView = UIView()
    let pickerView = UIPickerView()
    let pickerSaylaBtn = UIButton()
    let pickerCancel = UIButton()
    let blackView = UIView()
    var selectedCount = Int()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        contentView.addSubview(checkBoxBtn)
        contentView.addSubview(productImgView)
        contentView.addSubview(nameLb)
//        contentView.addSubview(sizeKeyLb)
//        contentView.addSubview(sizeValueLb)
        contentView.addSubview(idStackView)
        contentView.addSubview(sizeBtn)
//        contentView.addSubview(idKeyLb)
//        contentView.addSubview(idValueLb)
        contentView.addSubview(countBtn)
        contentView.addSubview(priceLb)
        contentView.addSubview(discountLb)
        contentView.addSubview(removeBtn)
        contentView.addSubview(hiddenCheckBtn)
        idStackView.addArrangedSubview(idKeyLb)
        idStackView.addArrangedSubview(idValueLb)
        productImgView.image = UIImage(named: "testImg")
        nameLb.text = "Trendyol erkek T-sheart geyim"
        sizeKeyLb.text = "Size:".localized()
        sizeValueLb.text = "48"
        idKeyLb.text = "Cart id:".localized()
        idValueLb.text = "Yellow"
        priceLb.text = "4039 TMT"
        discountLb.makeDiscount(price: "5039 TMT")
        countBtn.setTitle("Count: 1", for: .normal)
        hiddenCheckBtn.addTarget(self, action: #selector(clickCheckBtn), for: .touchUpInside)
        sizeBtn.addTarget(self, action: #selector(clickSize), for: .touchUpInside)
//        let sizeRec = UITapGestureRecognizer(target: self, action: #selector())
//        siaddGestureRecognizer(sizeRec)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            hiddenCheckBtn.leadingAnchor.constraint(equalTo: leadingAnchor),
            hiddenCheckBtn.topAnchor.constraint(equalTo: topAnchor),
            hiddenCheckBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            hiddenCheckBtn.widthAnchor.constraint(equalToConstant: 50),
            checkBoxBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            checkBoxBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            productImgView.leadingAnchor.constraint(equalTo: checkBoxBtn.trailingAnchor, constant: 16),
            productImgView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            productImgView.heightAnchor.constraint(equalToConstant: 80 * widthRatio),
            productImgView.widthAnchor.constraint(equalToConstant: 60 * widthRatio),
            nameLb.leadingAnchor.constraint(equalTo: productImgView.trailingAnchor, constant: 10),
            nameLb.topAnchor.constraint(equalTo: productImgView.topAnchor, constant: 10),
            nameLb.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -65),
            
//            sizeKeyLb.leadingAnchor.constraint(equalTo: nameLb.leadingAnchor),
//            sizeKeyLb.topAnchor.constraint(equalTo: nameLb.bottomAnchor, constant: 7 * widthRatio),
            
//            sizeValueLb.leadingAnchor.constraint(equalTo: sizeKeyLb.trailingAnchor, constant: 3),
//            sizeValueLb.centerYAnchor.constraint(equalTo: sizeKeyLb.centerYAnchor),
            sizeBtn.leadingAnchor.constraint(equalTo: nameLb.leadingAnchor),
            sizeBtn.topAnchor.constraint(equalTo: nameLb.bottomAnchor, constant: 7*widthRatio),
            
            idStackView.topAnchor.constraint(equalTo: productImgView.bottomAnchor, constant:  5),
            idStackView.centerXAnchor.constraint(equalTo: productImgView.centerXAnchor),
//            idKeyLb.centerXAnchor.constraint(equalTo: productImgView.centerXAnchor),
//            idKeyLb.topAnchor.constraint(equalTo: productImgView.bottomAnchor, constant: 7 * widthRatio),
//
//            idValueLb.leadingAnchor.constraint(equalTo: idKeyLb.trailingAnchor, constant: 3),
//            idValueLb.centerYAnchor.constraint(equalTo: idKeyLb.centerYAnchor),
            
            countBtn.leadingAnchor.constraint(equalTo: sizeBtn.trailingAnchor, constant: 10),
            countBtn.topAnchor.constraint(equalTo: sizeBtn.topAnchor),
            
            priceLb.bottomAnchor.constraint(equalTo: productImgView.bottomAnchor),
            priceLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            discountLb.bottomAnchor.constraint(equalTo: priceLb.topAnchor, constant: -2),
            discountLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            removeBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            removeBtn.topAnchor.constraint(equalTo: productImgView.topAnchor, constant: 10),
            
        ])
        countBtn.addTarget(self, action: #selector(clickCount), for: .touchUpInside)
        removeBtn.addTarget(self, action: #selector(clickRemove), for: .touchUpInside)
        productImgView.layer.cornerRadius = 8
        countBtn.layer.cornerRadius = 5
        sizeBtn.layer.cornerRadius = 5
    }
    
    func initData(cart: CartProduct){
        productImgView.sdImageLoad(imgUrl: cart.image ?? "", placeholder: true, placImg: nil)
        countBtn.setTitle("\(cart.count ?? 1)", for: .normal)
        nameLb.text = cart.name
//        sizeValueLb.text = cart.size
        sizeBtn.setTitle(cart.size, for: .normal)
        idValueLb.text = cart.cart_id?.stringValue
        discountLb.isHidden = true
        if (cart.price ?? 0) != 0{
            discountLb.isHidden = false
            discountLb.makeDiscount(price: "\((cart.price ?? 0).rounded(places: 2))")
        }
        priceLb.text = "\((cart.sale_price ?? 0).rounded(places: 2)) TMT"
    }
    
//    MARK: ACtions -
    
    @objc func clickRemove(){
        removeCallback?()
    }
    
    @objc func clickCount(){
        countCallback?()
    }
    
    @objc func clickCheckBtn(){
        checkBtnCallback?()
    }
    
    @objc func clickSize(){
        sizeCallback?()
    }
}


