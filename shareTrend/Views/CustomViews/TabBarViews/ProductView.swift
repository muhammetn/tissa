//
//  ProductView.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.04.2022.
//

import UIKit

class ProductView: UIView {
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        layout.estimatedItemSize = .zero
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(ProductSizeCell.self, forCellWithReuseIdentifier: "ProductSizeCell")
        collectionView.register(ProductHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProductHeader")
        collectionView.register(LastProductsCell.self, forCellWithReuseIdentifier: "LastProductsCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let addCartBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add to cart".localized(), for: .normal)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 16)
        btn.backgroundColor = .mainColor
        btn.setTitleColor(.white, for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 26, bottom: 10, right: 26)
        return btn
    }()
    
    let priceLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        lb.textColor = .black
        return lb
    }()
    
    let salePriceLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 15)
        lb.textColor = .mainColor
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
        addSubview(collectionView)
        addSubview(bottomView)
        bottomView.addSubview(addCartBtn)
        bottomView.addSubview(priceLb)
        bottomView.addSubview(salePriceLb)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 60),
            
            addCartBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            addCartBtn.leadingAnchor.constraint(equalTo: salePriceLb.trailingAnchor, constant: 30),
            addCartBtn.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            salePriceLb.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            salePriceLb.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: 5),
            
            priceLb.leadingAnchor.constraint(equalTo: salePriceLb.leadingAnchor),
            priceLb.bottomAnchor.constraint(equalTo: salePriceLb.topAnchor, constant: -1),
            
        ])
//        priceLb.makeDiscount(price: "2350")
        salePriceLb.text = "0 TMT"
        bottomView.layer.borderWidth = 0.5
        bottomView.layer.borderColor = UIColor.borderColor.cgColor
        addCartBtn.layer.cornerRadius = 5
    }
}

