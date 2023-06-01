//
//  MaintenanceVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 06.06.2022.
//

import UIKit
import Lottie

class MaintenenceVC: UIViewController{
    var update: Bool = false
    private var animationView: AnimationView?
    let descLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Regular", size: 18)
        lb.textColor = .gray
        lb.textAlignment = .center
        return lb
    }()
    
    let approveBtn: CustomBtn = {
        let btn = CustomBtn()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        let desc = update ? "update_required".localized(): "under_maintenance".localized()
        let btnTitle = update ? "update".localized() : "exit".localized()
        approveBtn.setTitle(btnTitle, for: .normal)
        descLb.text = desc
        view.addSubview(descLb)
        view.addSubview(descLb)
        view.addSubview(approveBtn)
        view.backgroundColor = .white
//        view.addSubview(customView)
        animationView = update ? .init(name: "update-app") : .init(name: "maintenance")
//        animationView!.frame = view.bounds
         // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
         // 4. Set animation loop mode
        animationView!.loopMode = .loop
         // 5. Adjust animation speed
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
         // 6. Play animation
        animationView!.play()
        setupConstraints()
        approveBtn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
    }
    
    func setupConstraints(){
        guard let animationView = animationView else { return }
        animationView.translatesAutoresizingMaskIntoConstraints = false
        descLb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 300),
            
            descLb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descLb.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descLb.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20),
            
            approveBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            approveBtn.topAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 30),
//            approveBtn.heightAnchor.cons
        ])
    }
    
    @objc func clickBtn(){
        if update{
            UIApplication.shared.open(URL(string: "https://apps.apple.com/tm/")!, options: [:], completionHandler: nil)
        }else{
            exit(0)
        }
    }
    
    
}
