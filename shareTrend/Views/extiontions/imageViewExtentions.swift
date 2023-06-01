//
//  imageViewExtentions.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.04.2022.
//

import UIKit
import ImageViewer_swift
import SDWebImage

extension UIImageView{
    func sdImageLoad(imgUrl: String?, placeholder: Bool, placImg: UIImage?){
        guard let imgUrl = imgUrl else { return }
        self.sd_imageTransition = .fade
        let strUrl = imgUrl
        if let img = placImg{
            self.sd_setImage(with: URL(string: strUrl), placeholderImage: placeholder ? img : nil, options: .waitStoreCache) { image, _, _, _ in
                guard let image = image else { return }
                self.setupImageViewer(images: [image])
            }
        }else{
            self.sd_setImage(with: URL(string: strUrl), placeholderImage: placeholder ? #imageLiteral(resourceName: "cardimage") : nil, options: .waitStoreCache) { image, _, _, _ in
                guard let image = image else { return }
                self.setupImageViewer(images: [image])
            }
        }
    }
    
    func sdImageLoadWithoutVisible(imgUrl: String?, placeholder: Bool, placImg: UIImage?){
        guard let imgUrl = imgUrl else { return }
        self.sd_imageTransition = .fade
        let strUrl = imgUrl
        if let img = placImg{
            self.sd_setImage(with: URL(string: strUrl), placeholderImage: placeholder ? img : nil, options: .waitStoreCache) { image, _, _, _ in
//                guard let image = image else { return }
//                self.setupImageViewer(images: [image])
            }
        }else{
            self.sd_setImage(with: URL(string: strUrl), placeholderImage: placeholder ? #imageLiteral(resourceName: "cardimage") : nil, options: .waitStoreCache) { image, _, _, _ in
//                guard let image = image else { return }
//                self.setupImageViewer(images: [image])
            }
        }
    }
    
    func sdImageLoadBanner(imgUrl: String?, url: URL, index: Int, completion: @escaping(UIImage?, Int)->()){
        guard let imgUrl = imgUrl else { return completion(nil, index)}
        self.sd_imageTransition = .fade
        self.sd_setImage(with: URL(string: imgUrl), placeholderImage: nil, options: .waitStoreCache) { image, _, _, _ in
            completion(image, index)
        }
    }
}
