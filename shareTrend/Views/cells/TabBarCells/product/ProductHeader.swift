//
//  HeaderView.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 25.04.2022.
//

import UIKit

protocol HeaderDelegate {
    func imageClicked(index: Int?, smallImages: [UIImage]?)
}

class ProductHeader: UICollectionReusableView {
    let trademakrLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Bold", size: 24)
        return lb
    }()
    
    let nameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 12)
        return lb
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: scWidth * 10, height: 350 * widthRatio)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isPagingEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    var smallImages = [UIImage]()
    
    var delegate: HeaderDelegate?
    var callBack: ()->([UIImage]?, Int?) = {  return (nil, nil)}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        isSkeletonable = true
        addSubview(trademakrLb)
        addSubview(nameLb)
        addSubview(scrollView)
        nameLb.text = "Unisex Spor Ayakkabı - Sneaker Sneaker 212152"
        trademakrLb.text = "Vans"
        scrollView.isSkeletonable = true
        nameLb.isSkeletonable = true
        trademakrLb.isSkeletonable = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 350*widthRatio),
            
            trademakrLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trademakrLb.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            nameLb.leadingAnchor.constraint(equalTo: trademakrLb.leadingAnchor),
            nameLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLb.topAnchor.constraint(equalTo: trademakrLb.bottomAnchor, constant: 8),
        ])
    }
    
    func initData(product: Product){
        smallImages.removeAll()
        scrollView.subviews.forEach({$0.removeFromSuperview()})
        nameLb.text = product.name
        trademakrLb.text = product.brand
        guard let images = product.images else {return}
        images.forEach { _ in
            smallImages.append(UIImage())
        }
        scrollView.contentSize = CGSize(width: scWidth * CGFloat(images.count), height: 350 * widthRatio)
        var count = 0
        for image in images{
            let imageView = UIImageView()
            scrollView.addSubview(imageView)
            let url = URL(string: image.large ?? "")!
            imageView.sdImageLoadBanner(imgUrl: image.medium ?? "", url: url, index: count, completion: {image, index in
                guard let image = image else {
                    return
                }
                self.smallImages[index] = image
            })
            imageView.frame = CGRect(x: CGFloat(count) * scWidth, y: 0, width: scWidth, height: 350 * widthRatio)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            let rec = CustomRec(target: self, action: #selector(clickImage(_:)))
            rec.index = count
            rec.images = smallImages
            imageView.addGestureRecognizer(rec)
            count += 1
        }
        isUserInteractionEnabled = true
//        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleGesture(gesture:))))
    }
    
    @objc func handleGesture(gesture: UIPanGestureRecognizer){
        if gesture.state == .began{
            print("begin")
        }else if gesture.state == .changed {
            let translation = gesture.translation(in: self)
            transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        }else if gesture.state == .ended{
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.transform = .identity
            }
        }
    }
    
    @objc func clickImage(_ sender: CustomRec){
//        callBack = {
//            (sender.index, smallImages)
//        }
        delegate?.imageClicked(index: sender.index, smallImages: smallImages)
    }
}
