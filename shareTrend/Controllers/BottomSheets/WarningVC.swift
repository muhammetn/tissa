//
//  WarningVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 30.04.2022.
//

import UIKit

class WarningVC: UIViewController {
    
//    MARK: Variables -
    let mainView = WarningView(title: nil, description: "Are you sure?".localized())
    var delegate: WarningDelegate?
    var row = Int()
    
//    MARK: VC Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
//    MARK: Custom methods-
    private func setupUI(){
        view = mainView
        mainView.closeBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        mainView.cancelBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        mainView.acceptBtn.addTarget(self, action: #selector(clickAcceptBtn), for: .touchUpInside)
    }
    
    @objc func clickAcceptBtn(){
        dismiss(animated: true) {[self] in 
            delegate?.acceptClicked(row: row)
        }
    }
    
    @objc func closeClick(){
        dismiss(animated: true, completion: nil)
    }
}
