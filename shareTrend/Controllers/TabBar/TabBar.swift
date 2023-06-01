//
//  TabBar.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.04.2022.
//

import UIKit
import SQLite

class TabBar: CustomTabBarController{
    var dataBase: Connection!
    var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "splash_screen")
        return image
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        tabBar.tintColor = .mainColor
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("product").appendingPathExtension("sqlite3")
            let dataBase = try Connection(fileUrl.path)
            SqlFile.dataBase = dataBase
        }catch{
            print(error.localizedDescription)
        }
        dataBase = SqlFile.dataBase
        SqlFile.createTable()
        postPing()
        view.addSubview(imageView)
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFill
//        setTabBarAppearance()
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: 15
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width/7
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.white.cgColor
        
        tabBar.tintColor = .mainColor
//        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,title: String,image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.shadowColor = .white
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                              NSAttributedString.Key.font: UIFont(name: "ProximaNova-Bold", size: 16)!]
            navController.navigationBar.standardAppearance = appearance
            navController.navigationBar.scrollEdgeAppearance = appearance
        }else{
            navController.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "ProximaNova-Bold", size: 16)!]
        }
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupVCs(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.estimatedItemSize = .zero
        let home = HomeVC(collectionViewLayout: layout)
        home.imageView = imageView
        viewControllers = [
            createNavController(for: home, title: "Home".localized(), image: UIImage(named: "home-home_symbol")),
            createNavController(for: ProductVC(), title: "Products".localized(), image: UIImage(named: "addCart")),
            createNavController(for: CartVC(), title: "Cart".localized(), image: UIImage(named: "shopping_cart")),
            createNavController(for: ProfileVC(), title: "Profile".localized(), image: UIImage(named: "user"))
        ]
    }
    
    private func postPing(){
        Network.shared.ping { error in
            let errorDialog = Components.shared.getErrorDialog(message: error){
                exit(0)
            }
            let retryAction = UIAlertAction(title: "Retry".localized(), style: .cancel) {[weak self] _ in
                self?.postPing()
            }
            errorDialog.addAction(retryAction)
            self.present(errorDialog, animated: true, completion: nil)
            print(error)
        } success: {[self] response in
//            UIView.animate(withDuration: 0.5) {
//                self.imageView.alpha = 0
//            }
//            view.layoutIfNeeded()
            DispatchQueue.main.async(execute: {
                switch response.body ?? "success" {
                case "success":
                    self.setupVCs()
                case "update_required":
                    self.showDialog(update: true)
                case "under_maintenance":
                    self.showDialog(update: false)
                case "popup_image":
                    popImage = response.img
                    popSrc = response.src
                    self.setupVCs()
                default:
                    self.showDialog(update: true)
                }
//                DispatchQueue.main.async{
//                    imageView.removeFromSuperview()
//                }
            })
        }
    }
    
    
    func showUpdateDialog(){
        let alert = UIAlertController(title: "Alert".localized(), message: "Please update to latest version!".localized(), preferredStyle: .alert)
        let action = UIAlertAction(title: "Update".localized(), style: .default) { _ in
            UIApplication.shared.open(URL(string: "https://apps.apple.com/tm/")!, options: [:], completionHandler: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showDialog(update: Bool){
        let vc = MaintenenceVC()
        vc.modalPresentationStyle = .fullScreen
        vc.update = false
        present(vc, animated: true, completion: nil)
    }
    
}
