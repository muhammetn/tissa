//
//  CartView.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 28.04.2022.
//

import UIKit

class CartView: UIView {
    var bottomCallback: (()->())?
    
    let blackView: CustomBlackView = {
        let view = CustomBlackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let priceView: CartBottomView = {
        let view = CartBottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(CartCell.self, forCellReuseIdentifier: "CartCell")
        tb.register(CargoTypeCell.self, forCellReuseIdentifier: "CargoTypeCell")
        return tb
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let aproveBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sebedi tassykla".localized(), for: .normal)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 16)
        btn.backgroundColor = .mainColor
        btn.setTitleColor(.white, for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        return btn
    }()
    
    let arrowImg: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "arrow")
        return image
    }()
    
    let sumValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Bold", size: 14)
        lb.textColor = .black
        return lb
    }()
    
    let sumKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        lb.text = "Jemi bahasy:".localized()
        lb.textColor = .black
        return lb
    }()
    
    var priceViewBottom = NSLayoutConstraint()
    
    let noCartImg: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "noCartProduct")
        return image
    }()
    
    let noCartLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "No cart".localized()
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 20)
        lb.textColor = .gray
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(noCartImg)
        addSubview(noCartLb)
        addSubview(bottomView)
        addSubview(priceView)
        addSubview(tableView)
        bottomView.addSubview(aproveBtn)
        bottomView.addSubview(sumValueLb)
        bottomView.addSubview(arrowImg)
        bottomView.addSubview(sumKeyLb)
        let rec = UITapGestureRecognizer(target: self, action: #selector(clickedBottom))
        bottomView.addGestureRecognizer(rec)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 60),
            
            arrowImg.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            arrowImg.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            aproveBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
//            addCartBtn.leadingAnchor.constraint(equalTo: salePriceLb.trailingAnchor, constant: 50),
            aproveBtn.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            sumKeyLb.leadingAnchor.constraint(equalTo: arrowImg.trailingAnchor, constant: 10),
            sumKeyLb.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: -10),
            
            sumValueLb.leadingAnchor.constraint(equalTo: sumKeyLb.leadingAnchor),
            sumValueLb.topAnchor.constraint(equalTo: sumKeyLb.bottomAnchor, constant: 3),
            
            priceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceView.trailingAnchor.constraint(equalTo: trailingAnchor),
            priceView.heightAnchor.constraint(equalToConstant: 150*widthRatio),
            noCartImg.centerXAnchor.constraint(equalTo: centerXAnchor),
            noCartImg.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            
            noCartLb.centerXAnchor.constraint(equalTo: centerXAnchor),
            noCartLb.topAnchor.constraint(equalTo: noCartImg.bottomAnchor, constant: 15),
            
        ])
        priceViewBottom = priceView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        priceViewBottom.isActive = true
        priceViewBottom.constant = 240
        bottomView.layer.borderWidth = 0.5
        bottomView.layer.borderColor = UIColor.borderColor.cgColor
        aproveBtn.layer.cornerRadius = 5
        arrowImg.transform = CGAffineTransform(rotationAngle: .pi)
        sumValueLb.text = "0.0 TMT"
    }
    
    func showPriceView(){
        bottomView.isUserInteractionEnabled = false
        addSubview(blackView)
        NSLayoutConstraint.activate([
            blackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            blackView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
        ])
        bringSubviewToFront(priceView)
        bringSubviewToFront(bottomView)
        blackView.alpha = 0
        bottomView.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {[self] in
            UIView.animate(withDuration: 0.3, delay: 0.1, animations: {
                blackView.alpha = 1
                arrowImg.transform = CGAffineTransform(rotationAngle: .pi*2)
                priceViewBottom.constant = 0
                layoutIfNeeded()
            }) { _ in
                bottomView.isUserInteractionEnabled = true
            }
        }
    }
    
    func hidePriceView(){
        bottomView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0.1, animations: {[self] in
            blackView.alpha = 0
            arrowImg.transform = CGAffineTransform(rotationAngle: .pi)
            priceViewBottom.constant = 240
            layoutIfNeeded()
        }) { [self] _  in
            blackView.removeFromSuperview()
            bottomView.isUserInteractionEnabled = true
        }
    }
    
    @objc func clickedBottom(){
        bottomCallback?()
    }
}
