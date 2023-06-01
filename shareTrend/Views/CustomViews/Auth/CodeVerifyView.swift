//
//  CodeVerifyVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit
import MaterialComponents

class CodeVerifyView: UIView, UITextFieldDelegate {
    let codeField: MDCOutlinedTextField = {
        let field = MDCOutlinedTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont(name: "ProximaNova-Regular", size: 16)
        field.label.text = "Code".localized()
        field.label.textColor = .black
        field.keyboardType = .numberPad
//        field.textContentType = .telephoneNumber
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
        return field
    }()
    
    let approveBtn: CustomBtn = {
        let btn = CustomBtn()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Approve".localized(), for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50)
        return btn
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
        backgroundColor = .white
        addSubview(codeField)
        addSubview(approveBtn)
        
        if #available(iOS 12.0, *) {
            codeField.textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
        }
        codeField.leadingAssistiveLabel.text = "please enter verification code".localized()
        codeField.delegate = self
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            codeField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            codeField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            codeField.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
//            approveBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            approveBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            approveBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            approveBtn.topAnchor.constraint(equalTo: codeField.bottomAnchor, constant: 20),
            approveBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
}
