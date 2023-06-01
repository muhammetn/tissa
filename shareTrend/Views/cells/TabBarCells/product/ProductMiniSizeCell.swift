//
//  ProductSizeCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 28.04.2022.
//

import UIKit

class ProductMiniSizeCell: UICollectionViewCell {
    let sizeLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return lb
    }()
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                layer.borderColor = UIColor.mainColor.cgColor
                backgroundColor = .mainColor
                sizeLb.textColor = .white
            }else{
                sizeLb.textColor = .black
                layer.borderWidth = 1
                layer.borderColor = UIColor.lightGray.cgColor
                backgroundColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(sizeLb)
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            sizeLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sizeLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sizeLb.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            sizeLb.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
//            sizeLb.centerXAnchor.constraint(equalTo: centerXAnchor),
//            sizeLb.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
