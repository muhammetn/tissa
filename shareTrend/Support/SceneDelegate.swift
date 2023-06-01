//
//  SceneDelegate.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.04.2022.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let suiteName = "group.shareTrend"
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        UINavigationBar.appearance().barTintColor = .white
        // To change colour of tappable items.
        UINavigationBar.appearance().tintColor = .black
        // To control navigation bar's translucency.
        UINavigationBar.appearance().isTranslucent = true
        let tabbar = TabBar()
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
//        setupNotification()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    
    
//    func setupNotification() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(setUrl),
//            name: UIApplication.didBecomeActiveNotification,
//            object: nil
//        )
//    }
    
//    @objc func setUrl(){
//        if let pref = UserDefaults(suiteName: suiteName){
//            if let name = pref.string(forKey: "Name"){
//                let check = pref.bool(forKey: "fromTrendyol")
//                if check{
//                    print("name:\(name)")
//                    let tabbar = TabBar()
//                    tabbar.selectedIndex = 1
//                    window?.rootViewController = tabbar
////                    searchController.searchBar.text = name
////                    getProduct(url: searchController.searchBar.text)
////                    pref.removeObject(forKey: "fromTrendyol")
//                }
//            }
//        }
//    }

}

