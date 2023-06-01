//
//  PickerView.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 30.04.2022.
//

import UIKit


class PickerView: UIView {
    let tertipLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Bold", size: 16)
        return lb
    }()
    
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .passiveColor
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.borderColor.cgColor
        return view
    }()
    
    let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Yatyr".localized(), for: .normal)
        btn.setTitleColor(.mainColor, for: .normal)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Regular", size: 14)
        return btn
    }()
    
    let selectBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sayla".localized(), for: .normal)
        btn.setTitleColor(.mainColor, for: .normal)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Regular", size: 14)
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
    
    convenience init(title: String) {
        self.init(frame: .zero)
        tertipLabel.text = title
    }
    
    private func setupViews() {
        addSubview(headerView)
        addSubview(pickerView)
        headerView.addSubview(tertipLabel)
        headerView.addSubview(selectBtn)
        headerView.addSubview(cancelBtn)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -1),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 1),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60 ),
            
            tertipLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            tertipLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            pickerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.widthAnchor.constraint(equalToConstant: scWidth),
            selectBtn.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -25),
            selectBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            cancelBtn.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 25),
            cancelBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
        ])
    }
    
    func createPicker(){
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        pickerCancel.addTarget(self, action: #selector(handleDismiss(sender:)), for: .touchUpInside)
//        selectBtn.addTarget(self, action: #selector(clickSayla), for: .touchUpInside)
    }
}
