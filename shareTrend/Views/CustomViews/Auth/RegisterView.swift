//
//  RegisterVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit
import MaterialComponents

class RegisterView: UIView {
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
//    let headerLb: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "ProximaNova-bold", size: 32)
//        label.text = "Register".localized()
//        label.textAlignment = .center
//        return label
//    }()
    
    let descLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ProximaNova-Regular", size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Please enter all information fields".localized()
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
    
    let nameField: MDCOutlinedTextField = {
        let field = MDCOutlinedTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont(name: "ProximaNova-Regular", size: 16)
        field.label.text = "Name".localized()
        field.label.textColor = .black
        field.keyboardType = .alphabet
        field.textContentType = .username
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
    
    let addressField: MDCOutlinedTextField = {
        let field = MDCOutlinedTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont(name: "ProximaNova-Regular", size: 16)
        field.label.text = "Address".localized()
        field.label.textColor = .black
        field.keyboardType = .alphabet
        field.textContentType = .addressCity
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
    
    let emailField: MDCOutlinedTextField = {
        let field = MDCOutlinedTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont(name: "ProximaNova-Regular", size: 16)
        field.label.text = "email*".localized()
        field.label.textColor = .black
        field.keyboardType = .emailAddress
        field.textContentType = .emailAddress
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
    
    let invitationField: MDCOutlinedTextField = {
        let field = MDCOutlinedTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont(name: "ProximaNova-Regular", size: 16)
        field.label.text = "Invitation code*".localized()
        field.label.textColor = .black
        field.keyboardType = .alphabet
        field.textContentType = .name
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
        btn.setTitle("continue".localized(), for: .normal)
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
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleKeyboard)))
        addSubview(scrollView)
        scrollView.addSubview(descLb)
        scrollView.addSubview(phoneField)
        scrollView.addSubview(nameField)
        scrollView.addSubview(addressField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(invitationField)
        scrollView.addSubview(approveBtn)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            descLb.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            descLb.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 38),
            descLb.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -38),
            
            phoneField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            phoneField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            phoneField.topAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 20),
            
            nameField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            nameField.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 20),
            
            addressField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            addressField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            addressField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            
            emailField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            emailField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            emailField.topAnchor.constraint(equalTo: addressField.bottomAnchor, constant: 20),
            
            invitationField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            invitationField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            invitationField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            
            approveBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            approveBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            approveBtn.topAnchor.constraint(equalTo: invitationField.bottomAnchor, constant: 20),
            approveBtn.heightAnchor.constraint(equalToConstant: 50),
            approveBtn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
//            scrollView.contentLayoutGuide.heightAnchor.constraint(equalToConstant: 1200)
            
        ])
//        scrollView.contentSize = CGSize(width: scWidth, height: 1200)
    }
    
    @objc func handleKeyboard(){
        endEditing(true)
    }
}
