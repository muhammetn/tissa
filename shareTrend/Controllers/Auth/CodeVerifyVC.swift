//
//  CodeVerifyVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit
import SVProgressHUD

class CodeVerifyVC: UIViewController {
    let mainView = CodeVerifyView()
    var phone = String()
    var fromSignin = true
    var registerUser = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupViews(){
        view = mainView
        mainView.codeField.becomeFirstResponder()
        mainView.approveBtn.addTarget(self, action: #selector(clickedApprove), for: .touchUpInside)
    }
    
    @objc func clickedApprove(){
        fromSignin ? signin() : signup()
    }
    
    func signin(){
        guard let code = mainView.codeField.text else {return}
        let wait = Components.shared.waitDialog(view: view)
        Network.shared.signin(phone: phone, code: code) {[self] error in
            print(error)
            SVProgressHUD.dismiss()
            let errorDialog = Components.shared.getErrorDialog(message: error)
            present(errorDialog, animated: true, completion: nil)
            view.isUserInteractionEnabled = true
            wait.removeFromSuperview()
        } success: { [self] user in
            wait.removeFromSuperview()
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            UserDefaults.standard.set(user.user_id?.stringValue ?? "", forKey: "userid")
            UserDefaults.standard.set(true, forKey: "auth")
            UserDefaults.standard.set(user.token ?? "", forKey: "token")
            NotificationCenter.default.post(name: Notification.Name("userEnter"), object: nil)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func signup(){
        guard let code = mainView.codeField.text else { return }
        let wait = Components.shared.waitDialog(view: view)
        Network.shared.signup(phone: registerUser.phone ?? "", invite_code: registerUser.inviteCode, fullname: registerUser.fullname ?? "", address: registerUser.address ?? "", email: registerUser.email, code: code) {[self] error in
            print(error)
            SVProgressHUD.dismiss()
            let errorDialog = Components.shared.getErrorDialog(message: error)
            present(errorDialog, animated: true, completion: nil)
            view.isUserInteractionEnabled = true
            wait.removeFromSuperview()
        } success: { [self] user in
            wait.removeFromSuperview()
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            UserDefaults.standard.set(user.user_id?.stringValue ?? "", forKey: "userid")
            UserDefaults.standard.set(true, forKey: "auth")
            UserDefaults.standard.set(user.token ?? "", forKey: "token")
            NotificationCenter.default.post(name: Notification.Name("userEnter"), object: nil)
            dismiss(animated: true, completion: nil)
        }
    }
}
