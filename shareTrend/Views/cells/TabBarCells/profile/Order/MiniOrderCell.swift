//
//  MiniOrderCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 10.05.2022.
//

import UIKit

class MiniOrderCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
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
        addSubview(imageView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func layoutSubviews() {
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.passiveColor.cgColor
        imageView.layer.borderWidth = 1
    }
    
    func setupData(product: OrderProduct){
        imageView.sdImageLoad(imgUrl: product.image, placeholder: true, placImg: nil)
    }
}
