//
//  BannerCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.05.2022.
//

import UIKit


class HomeBannerCell: UICollectionViewCell {
    var cellCallback: (()->())?
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        imageView.layer.cornerRadius = 0
        imageView.clipsToBounds = true
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews(){
        contentView.addSubview(imageView)
        let rec = UITapGestureRecognizer(target: self, action: #selector(cellClicked))
        addGestureRecognizer(rec)
    }
    
    var imageCenter = NSLayoutConstraint()
    var parallaxOffset: CGFloat = 0 {
        didSet{
            imageCenter.constant = parallaxOffset
        }
    }
    private func setupConstraints(){
        imageCenter = imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            MARK: Make image.height = 300, for Parallax
            imageView.heightAnchor.constraint(equalToConstant: 170 * widthRatio),
            imageCenter,
//            imageView.topAnchor.constraint(equalTo: topAnchor),
//            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        imageView.isSkeletonable = true
        contentView.isSkeletonable = true
    }
    
    func updateParallaxOffset(collectionViewBounds bounds: CGRect){
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let offsetFromCenter = CGPoint(x: center.x - self.center.x, y: center.y - self.center.y)
        let maxVerticalOffset = (bounds.height/2) + (self.bounds.height/2)
        let scaleFactor = 40 / maxVerticalOffset
        parallaxOffset = -offsetFromCenter.y * scaleFactor
    }
    
    @objc func cellClicked(){
        cellCallback?()
    }
    
}
