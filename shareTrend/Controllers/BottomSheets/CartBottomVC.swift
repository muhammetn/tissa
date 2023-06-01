//
//  CartBottomVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 07.05.2022.
//

import UIKit

class CartBottomVC: UIViewController {
    let mainView = CartBottomView()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupViews(){
        view = mainView
    }
    
    
}
