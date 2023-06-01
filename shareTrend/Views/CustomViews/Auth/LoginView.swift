//
//  LoginView.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import Foundation
import MaterialComponents
import UIKit

class LoginView: UIView{
    
    let closeImg: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Close_circle")
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let headerLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-bold", size: 32)
        label.text = "Login".localized()
        label.textAlignment = .center
        return label
    }()
    
    let descLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Regular", size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Please enter your phone number and get code".localized()
        return label
    }()
    
    let phoneField: MDCOutlinedTextField = {
        let field = MDCOutlinedTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont(name: "ProximaNova-Regular", size: 16)
        field.label.text = "Phone".localized()
        field.label.textColor = .black
        field.keyboardType = .phonePad
        field.textContentType = .telephoneNumber
        field.setFloatingLabelColor(.black, for: .disabled)
        field.setFloatingLabelColor(.black, for: .editing)
        field.setFloatingLabelColor(.black, for: .normal)
        
        field.setNormalLabelColor(.black, for: .disabled)
        field.setNormalLabelColor(.black, for: .editing)
        field.setNormalLabelColor(.black, for: .normal)
        field.setTextColor(.black, for: .normal)
        field.setTextColor(.black, for: .editing)
        field.setTextColor(.black, for: .disabled)
        field.setOutlineColor(.borderColor, for: .normal)
        field.setOutlineColor(.mainColor, for: .editing)
        field.text = "+993"
        return field
    }()
    
    let registerLb: UILabel = {
        let lb = UILabel()
        lb.isUserInteractionEnabled = true
        lb.text = "No Account? Register".localized()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 12)
        lb.underline()
        lb.textColor = .gray
        return lb
    }()
    
    
    let approveBtn: CustomBtn = {
        let btn = CustomBtn()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("continue".localized(), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = .white
        addSubview(headerLb)
        addSubview(descLb)
        addSubview(phoneField)
        addSubview(approveBtn)
        approveBtn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50)
        addSubview(registerLb)
        addSubview(closeImg)
        NSLayoutConstraint.activate([
            headerLb.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            headerLb.centerXAnchor.constraint(equalTo: centerXAnchor),
            descLb.topAnchor.constraint(equalTo: headerLb.bottomAnchor, constant: 5),
            descLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            descLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38),
            
            phoneField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            phoneField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            phoneField.topAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 20),
            
//            approveBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            approveBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            approveBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            approveBtn.topAnchor.constraint(equalTo: registerLb.bottomAnchor, constant: 20),
            approveBtn.heightAnchor.constraint(equalToConstant: 50),
            
            registerLb.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerLb.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 15),
            
            closeImg.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            closeImg.heightAnchor.constraint(equalToConstant: 30),
            closeImg.widthAnchor.constraint(equalToConstant: 30),
            closeImg.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
