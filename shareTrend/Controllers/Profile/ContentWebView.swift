//
//  HelpVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 26.05.2022.
//

import UIKit
import SVProgressHUD
import WebKit

class ContentWebView: UIViewController{
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    var page = String()
    var constantPage: ConstantPage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        title = page.localized()
        view.backgroundColor = .white
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        loadData()
    }
    
    func loadData(){
        let wait = Components.shared.waitDialog(view: view)
        Network.shared.getConstantPage(page: page) {[self] error in
            print(error)
            wait.removeFromSuperview()
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            let errorDialog = Components.shared.getErrorDialog(message: error)
            present(errorDialog, animated: true, completion: nil)
        } success: {[self] result in
            wait.removeFromSuperview()
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            constantPage = result
            webView.loadHTMLString(constantPage?.content ?? "", baseURL: nil)
        }
    }
}
