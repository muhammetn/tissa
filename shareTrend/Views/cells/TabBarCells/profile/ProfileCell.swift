//
//  ProfileCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 10.05.2022.
//

import UIKit

class ProfileCell: UITableViewCell {
    var img: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Bold", size: 14)
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(img)
        addSubview(titleLb)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            img.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 31),
            img.centerYAnchor.constraint(equalTo: centerYAnchor),
            img.heightAnchor.constraint(equalToConstant: 18 * widthRatio),
            img.widthAnchor.constraint(equalToConstant: 18 * widthRatio),
            
            titleLb.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 16),
            titleLb.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
        ])
    }
}
