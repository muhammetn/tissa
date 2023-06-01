//
//  QRCodeView.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 20.05.2022.
//

import UIKit
import Lottie

class QRCodeView: UIView {
    let codeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let closeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "Frame-2"), for: .normal)
        btn.layer.borderColor = UIColor.borderColor.cgColor
        btn.layer.borderWidth = 1
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(codeImageView)
//        addSubview(closeBtn)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            codeImageView.heightAnchor.constraint(equalToConstant: scWidth/2),
            codeImageView.widthAnchor.constraint(equalToConstant: scWidth/2),
            codeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            codeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
