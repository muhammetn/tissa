//
//  LangSheetView.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 05.06.2022.
//

import UIKit

class LangSheetView: UIView {
    let ruBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.setTitle("Русский язык".localized(), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 16)
        return btn
    }()
    
    let tmBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.setTitle("Türkmen dili".localized(), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 16)
        return btn
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xE5E5E5)
        return view
    }()
    
    let closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Close_circle"), for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 16, left: 20, bottom: 10, right: 16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = .white
        addSubview(ruBtn)
        addSubview(tmBtn)
        addSubview(lineView)
        addSubview(closeBtn)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tmBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            tmBtn.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -15),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            lineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 146*widthRatio),
            ruBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            ruBtn.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 15),
            
            closeBtn.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            closeBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
        
    }
}
