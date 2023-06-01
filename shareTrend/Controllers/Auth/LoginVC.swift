//
//  LoginVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit
import SVProgressHUD

protocol LoginDelegate{
    func notify()
}

class LoginVC: UIViewController{
    let loginView = LoginView()
    var delegate: LoginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        navigationItem.backButtonTitle = ""
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        let registerRec = UITapGestureRecognizer(target: self,action: #selector(clickRegister))
        loginView.registerLb.addGestureRecognizer(registerRec)
        loginView.approveBtn.addTarget(self,action: #selector(login),for: .touchUpInside)
        let closeRec = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        loginView.closeImg.isUserInteractionEnabled = true
        loginView.closeImg.addGestureRecognizer(closeRec)
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func clickRegister(){
        let vc = RegisterVC()
        show(vc, sender: self)
    }
    
    @objc func login(){
        guard let phone = loginView.phoneField.text else {return}
        if phone.count != 12 {
            return
        }
        let wait = Components.shared.waitDialog(view: view)
        Network.shared.startVerification(phone: phone) {[self] error in
            print(error)
            SVProgressHUD.dismiss()
            let errorDialog = Components.shared.getErrorDialog(message: error)
            present(errorDialog, animated: true, completion: nil)
            view.isUserInteractionEnabled = true
            wait.removeFromSuperview()
        } success: {[self] body in
            wait.removeFromSuperview()
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            if body == "exists"{
                let vc = CodeVerifyVC()
                vc.phone = phone
                show(vc, sender: self)
            }else{
                let alert = UIAlertController(title: "Not registered".localized(), message: "Do you want register?".localized(), preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
                let ok = UIAlertAction(title: "Register".localized(), style: .default) { _ in
                    let vc = RegisterVC()
                    vc.fromLogin = true
                    vc.phone = loginView.phoneField.text ?? "+993"
                    show(vc, sender: self)
                }
                alert.addAction(cancel)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
        }
    }
}
