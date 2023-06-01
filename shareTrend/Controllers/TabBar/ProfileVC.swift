//
//  ProfileVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.04.2022.
//

import UIKit
import FittedSheets
import SVProgressHUD

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    let mainView = ProfileView()
    var auth = UserDefaults.standard.bool(forKey: "auth")
    let names = ["Orders".localized(), "Help".localized(), "Language".localized(), "Generate invitation code".localized(), "Log out".localized(), "remove account".localized()]
    let imgs = ["zakazlarym", "help-help_symbol", "language-language_symbol", "qrcode-scan", "logout-logout_symbol", "remove"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        auth = UserDefaults.standard.bool(forKey: "auth")
        mainView.tableView.reloadData()
    }
    
    func setupView(){
        view = mainView
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    func showAuthVC(){
        let vc = LoginVC()
        let navBar = UINavigationController(rootViewController: vc)
        navBar.modalPresentationStyle = .fullScreen
        present(navBar, animated: true, completion: {
//            self.tabBarController?.selectedIndex = 0
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auth ? names.count : names.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        if indexPath.row == (names.count-2){
            if auth {
                cell.titleLb.text = names[indexPath.row]
                cell.img.image = UIImage(named: "\(imgs[indexPath.row])")
            }else{
                cell.titleLb.text = "login".localized()
                cell.img.image = UIImage(named: "login-login_symbol")
            }
        }else{
            cell.titleLb.text = names[indexPath.row]
            cell.img.image = UIImage(named: "\(imgs[indexPath.row])")
        }
        cell.img.tintColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if !auth {
                showAuthVC()
            }else{
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
                layout.estimatedItemSize = .zero
                let vc = OrdersVC(collectionViewLayout: layout)
                show(vc, sender: self)
            }
        case 1:
            let vc = ContentWebView()
            vc.page = "help"
            show(vc, sender: self)
        case 2:
            showLangSheet()
        case 3:
            if !auth {
                showAuthVC()
            }else{
                let vc = QRCodeVC()
                show(vc, sender: self)
            }
        case 4:
            if !auth {
                showAuthVC()
            }else{
                logOut()
            }
        case 5:
//            changeHost()
            removeAccount()
        default:
            print(indexPath.row)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func logOut(){
        let alert = UIAlertController(title: "Log out".localized(), message: "Are you sure?".localized(), preferredStyle: .alert)
        let ok = UIAlertAction(title: "Log out".localized(), style: .destructive) { _ in
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "auth")
            UserDefaults.standard.removeObject(forKey: "userid")
            UIApplication.shared.keyWindow?.rootViewController = TabBar()
        }
        let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showLangSheet(){
        var sheetOptions = SheetOptions()
        sheetOptions.presentingViewCornerRadius = 16
        sheetOptions.pullBarHeight = 0
        sheetOptions.shouldExtendBackground = false
        sheetOptions.shrinkPresentingViewController = false
        sheetOptions.transitionVelocity = 0
        sheetOptions.transitionDampening = 1
        let vc = LangSheetVC()
        let sheetVC = SheetViewController(controller: vc, sizes: [.fixed(145*widthRatio)], options: sheetOptions)
        present(sheetVC, animated: true, completion: nil)
    }
    
//    func changeHost(){
//        let alert = UIAlertController(title: "Change host?", message: nil, preferredStyle: .alert)
//        let oldHost = Network.shared.BASE_URL
//        alert.addTextField { text in
//            text.placeholder = oldHost
//            text.textContentType = .telephoneNumber
//            text.delegate = self
//        }
//        let ok = UIAlertAction(title: "Ok", style: .default) { _ in
//        }
//        alert.addAction(ok)
//        present(alert, animated: true, completion: nil)
//    }
    
    func removeAccount(){
        let alert = UIAlertController(title: "remove account".localized(), message: "remove_account_info".localized(), preferredStyle: .alert)
        let ok = UIAlertAction(title: "remove".localized(), style: .destructive) { [self] _ in
            let wait = Components.shared.waitDialog(view: view)
            Network.shared.deleteUser { error in
                print(error)
                wait.removeFromSuperview()
                view.isUserInteractionEnabled = true
                SVProgressHUD.dismiss()
                let error = Components.shared.getErrorDialog(message: error)
                present(error, animated: true, completion: nil)
            } success: {
                wait.removeFromSuperview()
                view.isUserInteractionEnabled = true
                SVProgressHUD.dismiss()
                UserDefaults.standard.removeObject(forKey: "token")
                UserDefaults.standard.removeObject(forKey: "auth")
                UserDefaults.standard.removeObject(forKey: "userid")
                UIApplication.shared.keyWindow?.rootViewController = TabBar()
            }
        }
        let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let newHost = "http://\(text):3130/"
        if (newHost != host) && text != "" {
            UserDefaults.standard.set(newHost, forKey: "host")
            Network.shared.BASE_URL = newHost
            UIApplication.shared.keyWindow?.rootViewController = TabBar()
        }
    }
}
