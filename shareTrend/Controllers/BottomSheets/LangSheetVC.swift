//
//  LangSheetVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 05.06.2022.
//

import UIKit
import SwiftUI

class LangSheetVC: UIViewController{
    let mainView = LangSheetView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view = mainView
        mainView.closeBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        mainView.ruBtn.addTarget(self, action: #selector(clickRu), for: .touchUpInside)
        mainView.tmBtn.addTarget(self, action: #selector(clickTm), for: .touchUpInside)
    }
    
    @objc func closeClick(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func clickRu(){
        UserDefaults.standard.setValue("ru", forKey: "lang")
        UIApplication.shared.keyWindow?.rootViewController = TabBar()
    }
    
    @objc func clickTm(){
        UserDefaults.standard.setValue("tk", forKey: "lang")
        UIApplication.shared.keyWindow?.rootViewController = TabBar()
    }
    
    
}
