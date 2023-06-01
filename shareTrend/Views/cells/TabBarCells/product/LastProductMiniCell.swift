//
//  LastProductMiniCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 28.04.2022.
//

import UIKit
import SkeletonView

class LastProductMiniCell: UICollectionViewCell {
    var cardView: UIView = {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ProximaNova-Regular", size: 12)
        label.text = "U.S.Polo.Assn"
        label.skeletonTextNumberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    var about: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = UIFont(name: "ProximaNova-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var discount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5647058824, green: 0.5647058824, blue: 0.5647058824, alpha: 1)
        label.font = UIFont(name: "ProximaNova-Regular", size: 12)
        return label
    }()
    
    var price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Bold", size: 12)
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        imageView.layer.cornerRadius = 8
        name.layer.cornerRadius = 5
        name.skeletonCornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        isUserInteractionDisabledWhenSkeletonIsActive = false
        SkeletonAppearance.default.multilineCornerRadius = 5
        SkeletonAppearance.default.multilineHeight = 20
        isSkeletonable = true
        contentView.isSkeletonable = true
        contentView.addSubview(cardView)
        contentView.addSubview(imageView)
        contentView.addSubview(name)
        contentView.addSubview(about)
        contentView.addSubview(discount)
        contentView.addSubview(price)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 100 * widthRatio),
            
            imageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 218 * widthRatio),
            
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            about.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            about.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            about.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            discount.topAnchor.constraint(equalTo: about.bottomAnchor, constant: 5),
            discount.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            
            price.topAnchor.constraint(equalTo: about.bottomAnchor, constant: 5),
            price.trailingAnchor.constraint(lessThanOrEqualTo: cardView.trailingAnchor),
            price.leadingAnchor.constraint(equalTo: discount.trailingAnchor),
        ])
        name.isSkeletonable = true
        imageView.isSkeletonable = true
    }
    
    func initData(product: RandomProduct?){
        name.textAlignment = .natural
        guard let product = product else { return }
        name.text = product.name
        price.text = "\(product.sale_price ?? 0) TMT"
        imageView.sdImageLoadWithoutVisible(imgUrl: product.image, placeholder: true, placImg: nil)
    }
    
}
