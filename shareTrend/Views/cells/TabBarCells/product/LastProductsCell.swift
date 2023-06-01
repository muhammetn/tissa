//
//  LastProductsCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 28.04.2022.
//

import UIKit
import SkeletonView

class LastProductsCell: UICollectionViewCell {
    var isVertical = true
    var view = UIView()
    var titleTopConstraint = NSLayoutConstraint()
    var showSkeleton: Bool = true{
        didSet{
            if showSkeleton{
//                isSkeletonable = true
//                collectionView.reloadData()
//                collectionView.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {[self] in
//                    collectionView.isHidden = false
                    collectionView.prepareSkeleton {[self] _ in
                        titleLb.isSkeletonable = true
                        titleLb.showAnimatedGradientSkeleton(usingGradient: .init(colors: [.skeletonDefault]), animation: nil, transition: .crossDissolve(0.25))
                        collectionView.isUserInteractionEnabled = false
                        collectionView.isSkeletonable = true
                        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(colors: [.skeletonDefault]), animation: nil, transition: .crossDissolve(0.25))
                    }
                }
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.titleLb.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
                    self.collectionView.isUserInteractionEnabled = true
                    self.collectionView.hideSkeleton(reloadDataAfter: false)
                }
            }
        }
    }
    
    var products: [RandomProduct]?{
        didSet {
            if !isVertical{
                if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.scrollDirection = .horizontal
                }
                titleTopConstraint.constant = 10
                titleLb.text = "Last products".localized()
            }else{
                if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.scrollDirection = .vertical
                }
                titleTopConstraint.constant = -10
                titleLb.text = ""
            }
        }
    }
    var cellCallback: ((Int)->())?
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 16)
        return lb
    }()
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(LastProductMiniCell.self, forCellWithReuseIdentifier: "LastProductMiniCell")
        collectionView.allowsMultipleSelection = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
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
        contentView.addSubview(titleLb)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isSkeletonable = true
//        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(colors: [.skeletonDefault]), animation: nil, transition: .crossDissolve(0.25))
        
    }
    
    private func setupConstraints(){
        titleTopConstraint = titleLb.topAnchor.constraint(equalTo: topAnchor, constant: -10)
        titleTopConstraint.isActive = true
        NSLayoutConstraint.activate([
            titleLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
        initCollection()
//        collectionView.backgroundColor = .gray
    }
    
    private func initCollection(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}


extension LastProductsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        MARK: iPad ucin 250 norm
        return CGSize(width: (scWidth/2) - 32 , height: 300 * widthRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastProductMiniCell", for: indexPath) as! LastProductMiniCell
        cell.initData(product: products?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellCallback?(indexPath.row)
    }
}


// MARK: Collection Skeleton -

extension LastProductsCell: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastProductMiniCell", for: indexPath) as! LastProductMiniCell
        cell.price.text = ""
        cell.name.textAlignment = .center
        cell.imageView.image = nil
        return cell
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
        cell.isSkeletonable = true
        cell.showAnimatedGradientSkeleton()
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "LastProductMiniCell"
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
}
