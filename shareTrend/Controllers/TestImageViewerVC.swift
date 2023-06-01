//
//  TestImageViewerVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 08.06.2022.
//

import UIKit

class TestImageViewerVC: UIViewController{
    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
