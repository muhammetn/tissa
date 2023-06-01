//
//  PickerVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 30.04.2022.
//

import UIKit

class PickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let mainView = PickerView(title: "Select".localized())
    let array = ["1","2","3","4","5","6","7","8","9","10"]
    var sizes: [Size]?
    var selectedRow: Int = 0
    var delegate: PickerDelegate?
    var tableRow: Int = 0
    var cartId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view = mainView
        mainView.pickerView.delegate = self
        mainView.pickerView.dataSource = self
        mainView.cancelBtn.addTarget(self, action: #selector(clickDismiss), for: .touchUpInside)
        mainView.selectBtn.addTarget(self, action: #selector(clickSelect), for: .touchUpInside)
    }
    
//    MARK: ACtions-
    @objc func clickSelect(){
        dismiss(animated: true) { [self] in
            if sizes != nil{
                delegate?.pcickerSelected(row: selectedRow, tableRow: tableRow, changeSize: true, cartId: cartId, size: sizes?[selectedRow])
            }else{
                delegate?.pcickerSelected(row: selectedRow, tableRow: tableRow, changeSize: false, cartId: cartId, size: nil)
            }
        }
    }
    
    @objc func clickDismiss(){
        dismiss(animated: true)
    }
    
//    MARK: Picker Methods -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if sizes != nil{
            return sizes!.count
        }else{
            return array.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "ProximaNova-Regular", size: 18)
        if sizes != nil{
            label.text =  sizes?[row].value
        }else{
            label.text =  array[row]
        }
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    
}
