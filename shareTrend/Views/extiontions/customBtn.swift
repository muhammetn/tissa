//
//  customBtn.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit

class CustomBtn: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.white, for: .normal)
        backgroundColor = .mainColor
        titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 16)
        layer.cornerRadius = 8
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 60, bottom: 10, right: 60)
    }
}
