//
//  CartBottomView.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 07.05.2022.
//

import UIKit

class CartBottomView: UIView {
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let priceKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        lb.textColor = .gray
        return lb
    }()
    
    let priceValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return lb
    }()
    
    let deliveryPriceKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        lb.textColor = .gray
        return lb
    }()
    
    let deliveryPriceValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return lb
    }()
    
    let deliveryDayKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        lb.textColor = .gray
        return lb
    }()
    
    let deliveryDayValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return lb
    }()
    
    let salePriceKeyLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        lb.textColor = .gray
        return lb
    }()
    
    let salePriceValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 14)
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
        addSubview(cardView)
        cardView.addSubview(priceKeyLb)
        cardView.addSubview(priceValueLb)
        cardView.addSubview(deliveryPriceKeyLb)
        cardView.addSubview(deliveryPriceValueLb)
        cardView.addSubview(salePriceKeyLb)
        cardView.addSubview(salePriceValueLb)
        cardView.addSubview(deliveryDayKeyLb)
        cardView.addSubview(deliveryDayValueLb)
    }
    
    private func setupConstraints(){
        backgroundColor = .white
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            
            deliveryDayKeyLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            deliveryDayKeyLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            
            deliveryPriceKeyLb.leadingAnchor.constraint(equalTo: priceKeyLb.leadingAnchor),
            deliveryPriceKeyLb.topAnchor.constraint(equalTo: deliveryDayKeyLb.bottomAnchor, constant: 10),
            
            priceKeyLb.leadingAnchor.constraint(equalTo: deliveryDayKeyLb.leadingAnchor),
            priceKeyLb.topAnchor.constraint(equalTo: deliveryPriceKeyLb.bottomAnchor, constant: 10),
            
            salePriceKeyLb.leadingAnchor.constraint(equalTo: priceKeyLb.leadingAnchor),
            salePriceKeyLb.topAnchor.constraint(equalTo: priceKeyLb.bottomAnchor, constant: 10),
            
            deliveryDayValueLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            deliveryDayValueLb.centerYAnchor.constraint(equalTo: deliveryDayKeyLb.centerYAnchor),
            
            deliveryPriceValueLb.trailingAnchor.constraint(equalTo: priceValueLb.trailingAnchor),
            deliveryPriceValueLb.centerYAnchor.constraint(equalTo: deliveryPriceKeyLb.centerYAnchor),
            
            priceValueLb.trailingAnchor.constraint(equalTo: deliveryDayValueLb.trailingAnchor),
            priceValueLb.centerYAnchor.constraint(equalTo: priceKeyLb.centerYAnchor),
            
            salePriceValueLb.trailingAnchor.constraint(equalTo: priceValueLb.trailingAnchor),
            salePriceValueLb.centerYAnchor.constraint(equalTo: salePriceKeyLb.centerYAnchor),
        ])
        
        deliveryDayKeyLb.text = "Delivery_day:".localized()
        deliveryDayValueLb.text = "10 gun"
        deliveryPriceKeyLb.text = "Delivery_price:".localized()
        deliveryPriceValueLb.text = "10 TMT"
        priceKeyLb.text = "Discount:".localized()
        salePriceKeyLb.text = "Total price:".localized()
        salePriceValueLb.text = "0 TMT"
        priceValueLb.text = "0 TMT"
        cardView.layer.borderColor = UIColor.borderColor.cgColor
        cardView.layer.borderWidth = 0.5
        cardView.layer.cornerRadius = 5
    }
}
