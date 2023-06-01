//
//  RegisterVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit
import SVProgressHUD

class RegisterVC: UIViewController, ScannerDelegate{
    
    let mainView = RegisterView()
    var fromLogin = false
    var phone = "+993"
    var code: String?
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
        title = "Register".localized()
        mainView.phoneField.text = phone
        mainView.approveBtn.addTarget(self, action: #selector(clickApprove), for: .touchUpInside)
        mainView.invitationField.isUserInteractionEnabled = true
        let rec = UITapGestureRecognizer(target: self, action: #selector(clickInvitationField))
        mainView.invitationField.addGestureRecognizer(rec)
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjuctForKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjuctForKeyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func startVer(){
        guard let phone = mainView.phoneField.text else {return}
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
        }
    }
    
    @objc func adjuctForKeyboard(notification: Notification){
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification{
            mainView.scrollView.contentInset = UIEdgeInsets.zero
        }else{
            mainView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
        }
        mainView.scrollView.scrollIndicatorInsets = mainView.scrollView.contentInset
    }
    
    func found(code: String) {
        self.code = code
        Network.shared.getUserFullname(token: code) { error in
            print(error)
        } success: { name in
            print(name)
            self.mainView.invitationField.text = name
        }
    }
    
    @objc func clickApprove(){
//        if !fromLogin{
        guard let phone = mainView.phoneField.text, let name = mainView.nameField.text, let address = mainView.addressField.text else {return}
        if phone.count == 12, name != "", address != "" {
            view.endEditing(true)
            startVer()
            let user = User(fullname: name, phone: phone, role: nil, email: mainView.emailField.text, address: address, user_id: nil, token: nil, inviteCode: code)
            let vc = CodeVerifyVC()
            vc.fromSignin = false
            vc.registerUser = user
            vc.phone = phone
            show(vc, sender: self)
        }
//            sigup()
//        }else{
////            sigup()
//        }
    }
    
    @objc func clickInvitationField(){
        view.endEditing(true)
        let vc = QRCodeReaderVC()
        vc.scanDelege = self
        show(vc, sender: self)
    }
    
}
