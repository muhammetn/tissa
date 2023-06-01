//
//  PopupImageVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 06.06.2022.
//

import UIKit

class PopupImageVC: UIViewController{
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.alpha = 0
        return image
    }()
    
    let closeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let blackView = CustomBlackView()
    var popImage = String()
    var popSrc = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.isOpaque = false
        view.backgroundColor = .clear
        if let window = UIApplication.shared.keyWindow{
            window.addSubview(blackView)
            blackView.frame = window.frame
        }
        closeBtn.setImage(UIImage(named: "close_bold"), for: .normal)
        closeBtn.imageView?.tintColor = .passiveColor
        blackView.addSubview(imageView)
        blackView.addSubview(closeBtn)
//        imageView.image = UIImage(named: "testImg")
        imageView.sdImageLoad(imgUrl: popImage, placeholder: false, placImg: nil)
        imageView.contentMode = .scaleAspectFit
//        if (imageView.bounds.size.width > ((UIImage*)imagesArray[i]).size.width && imageView.bounds.size.height > ((UIImage*)imagesArray[i]).size.height) {
//               imageView.contentMode = UIViewContentModeScaleAspectFit;
//        }
//        imageView.image = UIImage(named: "testImg")
//        let scHeight = UIScreen.main.bounds.height
        NSLayoutConstraint.activate([
//            blackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            blackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            blackView.topAnchor.constraint(equalTo: view.topAnchor),
//            blackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            imageView.leadingAnchor.constraint(equalTo: blackView.leadingAnchor,constant: 20),
            imageView.trailingAnchor.constraint(equalTo: blackView.trailingAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: blackView.topAnchor, constant: 150),
//            imageView.bottomAnchor.constraint(equalTo: closeBtn.bottomAnchor, constant: -20),
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: scWidth-40),
            
//            closeBtn.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 2),
            closeBtn.bottomAnchor.constraint(equalTo: blackView.bottomAnchor, constant: -35),
            closeBtn.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            closeBtn.heightAnchor.constraint(equalToConstant: 40),
            closeBtn.widthAnchor.constraint(equalToConstant: 40),
        ])
        UIView.animate(withDuration: 0.3) {
            self.imageView.alpha = 1
        }
        imageView.isUserInteractionEnabled = true
        let imgRec = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        imageView.addGestureRecognizer(imgRec)
        closeBtn.addTarget(self, action: #selector(clickClose), for: .touchUpInside)
        blackView.isUserInteractionEnabled = true
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickClose)))
    }
    
    @objc func clickClose(){
        blackView.removeFromSuperview()
        dismiss(animated: true)
    }
    
    @objc func clickImage(){
        blackView.removeFromSuperview()
        dismiss(animated: true)
        UIApplication.shared.open(URL(string: popSrc)!, options: [:], completionHandler: nil)
    }
}
