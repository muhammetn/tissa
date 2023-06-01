//
//  ProductCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 25.04.2022.
//

import UIKit
import SkeletonView

class ProductSizeCell: UICollectionViewCell {
    
    var showSkeleton: Bool = true{
        didSet{
            if showSkeleton{
                sizeValueLb.text = nil
//                sizeKeyLb.isHidden = true
                collectionView.isHidden = true
                sizeKeyLb.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault), animation: nil, transition: .crossDissolve(0.25))
//                collectionView.prepareSkeleton { [self] _ in
                collectionSkeletonView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault), animation: nil, transition: .crossDissolve(0.25))
//                }
            }else{
                collectionView.isHidden = false
                sizeKeyLb.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                collectionSkeletonView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            }
        }
    }
    
    var sizes: [Size]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var sizeSelected: ((Size)->())?
    
    let sizeKeyLb: UILabel = {
        let lb = UILabel()
        lb.text = "Size:".localized()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 16)
        return lb
    }()
    
    let sizeValueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 14)
        lb.textColor = .black
        return lb
    }()
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(ProductMiniSizeCell.self, forCellWithReuseIdentifier: "ProductMiniSizeCell")
        collectionView.allowsMultipleSelection = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
    let collectionSkeletonView: UIView = {
        let view = UIView()
        view.isHidden = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        isUserInteractionDisabledWhenSkeletonIsActive = false
        SkeletonAppearance.default.multilineCornerRadius = 5
        SkeletonAppearance.default.multilineHeight = 20
        SkeletonAppearance.default.skeletonCornerRadius = 5
        contentView.addSubview(sizeKeyLb)
        contentView.addSubview(sizeValueLb)
        contentView.addSubview(collectionSkeletonView)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        sizeValueLb.text = ""
        collectionSkeletonView.isSkeletonable = true
        sizeKeyLb.isSkeletonable = true
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            sizeKeyLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sizeKeyLb.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            sizeValueLb.leadingAnchor.constraint(equalTo: sizeKeyLb.trailingAnchor, constant: 5),
            sizeValueLb.centerYAnchor.constraint(equalTo: sizeKeyLb.centerYAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: sizeKeyLb.bottomAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            collectionSkeletonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionSkeletonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionSkeletonView.topAnchor.constraint(equalTo: sizeKeyLb.bottomAnchor, constant: 10),
            collectionSkeletonView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -10),
            
        ])
    }
}

extension ProductSizeCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sizes?.count ?? 0
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 50 * widthRatio, height: 50 * widthRatio)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductMiniSizeCell", for: indexPath) as! ProductMiniSizeCell
        if (sizes?[indexPath.row].inStock ?? -1) == 0{
            cell.sizeLb.textColor = .passiveColor
            cell.layer.borderColor = UIColor.passiveColor.cgColor
        }
        cell.sizeLb.text = sizes?[indexPath.row].value
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if (sizes?[indexPath.row].inStock ?? -1) == 0{
            return false
        }else{
            return true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let size = sizes?[indexPath.row] else { return }
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
        sizeValueLb.text = sizes?[indexPath.item].value
        sizeSelected?(size)
    }
    
}

//extension ProductSizeCell: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource{
//
//    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductMiniSizeCell", for: indexPath) as! ProductMiniSizeCell
//        SkeletonAppearance.default.multilineCornerRadius = 5
//        SkeletonAppearance.default.multilineHeight = 20
//        cell.layer.borderColor = UIColor.white.cgColor
//        return cell
//    }
//
//    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
//        SkeletonAppearance.default.multilineCornerRadius = 5
//        SkeletonAppearance.default.multilineHeight = 20
//        cell.isSkeletonable = true
//        cell.showAnimatedGradientSkeleton()
//    }
//
//    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        10
//    }
//
//    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
//        return "ProductMiniSizeCell"
//    }
//}
