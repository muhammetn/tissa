//
//  HomeVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.05.2022.
//

import UIKit
import SVProgressHUD
import SkeletonView

class HomeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var banner = [Banner]()
    var refreshController = UIRefreshControl()
    let suiteName = "group.trendCopy"
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let auth = UserDefaults.standard.bool(forKey: "auth")
        setupNotification()
//        if !auth { showAuthVC() }else{
        initViews()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let pref = UserDefaults(suiteName: suiteName){
            print(pref)
        }
        if let pref = UserDefaults(suiteName: suiteName){
            if pref.bool(forKey: "fromTrendyol"), let _ = pref.string(forKey: "Name"){
                tabBarController?.selectedIndex = 1
//                setupViews()
            }
        }
    }
    
    @objc func userEnterNotify(notification: Notification) {
//        loadData()
        setupViews()
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(userEnterNotify(notification:)), name: Notification.Name("userEnter"), object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setUrl),
//            didBecomeActiveNotification
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc func setUrl(){
        let content = UIPasteboard.general.string ?? ""
        if content.isValidURL && ((url ?? "") != content) {
            tabBarController?.selectedIndex = 1
        }else if let pref = UserDefaults(suiteName: suiteName){
            if pref.bool(forKey: "fromTrendyol"), let _ = pref.string(forKey: "Name"){
                tabBarController?.selectedIndex = 1
//                setupViews()
            }
        }
    }
    
    func initViews(){
        let content = UIPasteboard.general.string ?? ""
//        guard let content = content else { return }
        if content.isValidURL && ((url ?? "") != content) {
            tabBarController?.selectedIndex = 1
//            setupViews()
        }else if let pref = UserDefaults(suiteName: suiteName){
            if pref.bool(forKey: "fromTrendyol"), let _ = pref.string(forKey: "Name"){
                tabBarController?.selectedIndex = 1
//                setupViews()
            }
        }
        setupViews()
    }
    
    private func setupViews(){
        collectionView.alwaysBounceVertical = true
        collectionView.register(HomeBannerCell.self, forCellWithReuseIdentifier: "HomeBannerCell")
        refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshController)
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(colors: [.skeletonDefault]), animation: nil, transition: .crossDissolve(0.25))
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let self = self else {return}
            self.imageView.alpha = 0
        }completion: {[weak self] _ in
            guard let self = self else {return}
            self.imageView.removeFromSuperview()
            self.loadData()
        }
    }
    
    private func loadData(){
//        let wait = Components.shared.waitDialog(view: view)
        Network.shared.getHomeBanners {[self] error in
            print(error)
            SVProgressHUD.dismiss()
            refreshController.endRefreshing()
            let errorDialog = Components.shared.getErrorDialog(message: error)
            present(errorDialog, animated: true, completion: nil)
            collectionView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
//            view.isUserInteractionEnabled = true
//            wait.removeFromSuperview()
        } success: {[self] banners in
            refreshController.endRefreshing()
//            view.layoutIfNeeded()
//            wait.removeFromSuperview()
//            view.isUserInteractionEnabled = true
//            SVProgressHUD.dismiss()
            banner = banners
            collectionView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
            collectionView.reloadData()
//            collectionView.reloadData()
//            DispatchQueue.main.async {
//            }
            guard let popimage = popImage, let popsrc = popSrc else{ return }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.popup(image: popimage, src: popsrc)
            }
        }
    }
    
    func popup(image: String, src: String){
        let vc = PopupImageVC()
        vc.popImage = image
        vc.popSrc = src
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        popImage = nil
        popSrc = nil
    }
    
    @objc func refresh(){
//        refreshController.endRefreshing()
//        banner = []
//        view.hideSkeleton()
//        collectionView.reloadData()
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
//        collectionView.isSkeletonable = true
//        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(colors: [.skeletonDefault]), animation: nil, transition: .crossDissolve(0.25))
//        }
//        collectionView.reloadData()
        loadData()
    }
    
    func showAuthVC(){
        let vc = LoginVC()
        let navBar = UINavigationController(rootViewController: vc)
        navBar.modalPresentationStyle = .fullScreen
        present(navBar, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: scWidth, height: widthRatio*170)
        return CGSize(width: scWidth, height: widthRatio*170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banner.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCell", for: indexPath) as! HomeBannerCell
        cell.imageView.backgroundColor = .skeletonDefault
        cell.imageView.sdImageLoadWithoutVisible(imgUrl: banner[indexPath.row].image, placeholder: false, placImg: nil)
        cell.isUserInteractionEnabled = true
        cell.cellCallback = {
            self.clickedCell(path: self.banner[indexPath.row].url ?? "")
        }
        Components.shared.setShadow(cell)
//        MARK: For Parallax-
//        cell.updateParallaxOffset(collectionViewBounds: collectionView.bounds)
        return cell
    }
    
    func clickedCell(path: String){
        UIApplication.shared.open(URL(string: path)!, options: [:], completionHandler: nil)
    }
    
}



extension HomeVC: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "HomeBannerCell"
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
        cell.isSkeletonable = true
        cell.showAnimatedGradientSkeleton()
    }
}

//  MARK: - Parallax Effex from https://www.youtube.com/watch?v=B3I2Bj_Y6p8&list=PL23Revp-82LKxKN9SXqQ5Nxaa1ZpYEQua&index=14
//  MARK: HAVE TO=> cell.imageViewHeight > cellHeight
extension HomeVC{
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let cells = collectionView.visibleCells as [HomeBannerCell]
//        let bounds = collectionView.bounds
//        for cell in cells {
//            cell.updateParallaxOffset(collectionViewBounds: bounds)
//        }
//    }
}
