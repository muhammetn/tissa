//
//  WarninView.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 30.04.2022.
//

import UIKit

class WarningView: UIView {
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 18)
        return lb
    }()
    
    let descLB: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 16)
        return lb
    }()
    
    let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = UIColor(rgb: 0xE5E5E5)
        return btn
    }()
    
    let acceptBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .error
        return btn
    }()
    
    let closeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "Close_circle"), for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 16, left: 20, bottom: 10, right: 16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String?, description: String) {
        self.init(frame: .zero)
        descLB.text = description
        guard let title = title else { return }
        titleLb.text = title
    }
    
    private func setupUI(){
        backgroundColor = .white
        addSubview(titleLb)
        addSubview(descLB)
        addSubview(cancelBtn)
        addSubview(acceptBtn)
        addSubview(closeBtn)
        acceptBtn.setTitle("Hawa".localized(), for: .normal)
        cancelBtn.setTitle("Cancel".localized(), for: .normal)
        titleLb.text = "Alert".localized()
        cancelBtn.layer.cornerRadius = 4
        acceptBtn.layer.cornerRadius = 4
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLb.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLb.centerXAnchor.constraint(equalTo: centerXAnchor),
            descLB.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 15),
            descLB.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            cancelBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            cancelBtn.topAnchor.constraint(equalTo: descLB.bottomAnchor, constant: 25),
            cancelBtn.widthAnchor.constraint(equalToConstant: 120*widthRatio),
            cancelBtn.heightAnchor.constraint(equalToConstant: 40*widthRatio),
            
            acceptBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            acceptBtn.topAnchor.constraint(equalTo: cancelBtn.topAnchor),
            acceptBtn.bottomAnchor.constraint(equalTo: cancelBtn.bottomAnchor),
            acceptBtn.widthAnchor.constraint(equalToConstant: 120*widthRatio),
            
            closeBtn.topAnchor.constraint(equalTo: topAnchor),
            closeBtn.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}
