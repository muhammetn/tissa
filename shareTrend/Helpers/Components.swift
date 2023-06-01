//
//  Components.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit
import SVProgressHUD


class Components {
    static let shared = Components()
    init() {}
    
    func waitDialog(view: UIView)->UIView {
        let blackView = CustomBlackView()
        view.isUserInteractionEnabled = false
    //    let gradientLayer = RadialGradientLayer()
        if let window = UIApplication.shared.keyWindow {
            SVProgressHUD.show(withStatus: "Please wait...".localized())
            window.addSubview(blackView)
            blackView.frame = window.frame
    //        gradientLayer.frame = CGRect(x: -50, y: -50, width: blackView.frame.width+100, height: blackView.frame.height+100)
    //        gradientLayer.colors = [UIColor.white.cgColor, UIColor(white: 0, alpha: 0.3).cgColor]
    //        gradientLayer.setNeedsDisplay()
    //        blackView.layer.addSublayer(gradientLayer)
        }
        return blackView
    }
    
    func setShadow(_ viewShadow: UIView){
        viewShadow.backgroundColor = .white
    //    viewShadow.layer.shadowColor = UIColor(white: 0.7, alpha: 1).cgColor
        viewShadow.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        viewShadow.layer.shadowOpacity = 0.4
        viewShadow.layer.shadowOffset = CGSize(width: -1, height: 0)
        viewShadow.layer.shadowRadius = 10
    }
    
    func getErrorDialog(message: String)->UIAlertController{
        let errorDialog = UIAlertController(title: "Error".localized(), message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok".localized(), style: .default, handler: nil)
        errorDialog.addAction(ok)
        return errorDialog
    }
    
    func getErrorDialog(message: String, completion: @escaping()->())->UIAlertController{
        let errorDialog = UIAlertController(title: "Error".localized(), message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "exit".localized(), style: .default, handler: { _ in
            completion()
        })
        errorDialog.addAction(ok)
        return errorDialog
    }
}
