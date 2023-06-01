//
//  BlackVIew.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit

class CustomBlackView: UIView {
    var dismiss: (()->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        isUserInteractionEnabled = true
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        let disRec = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        addGestureRecognizer(disRec)
    }
    
    @objc func dismissAction(){
        dismiss?()
    }
}

