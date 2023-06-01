//
//  colorExtention.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.04.2022.
//

import UIKit


extension UIColor{
//    @objc class var blackColor: UIColor{
//        return UIColor(named: "blackColor")!
//    }
    
    @objc class var error: UIColor{
        return UIColor(named: "error")!
    }
    
    @objc class var mainColor: UIColor{
        return UIColor(named: "mainColor")!
    }
    
    @objc class var passiveColor: UIColor{
        return UIColor(named: "passiveColor")!
    }
    
    @objc class var passiveColor3: UIColor{
        return UIColor(named: "passiveColor3")!
    }
    
    @objc class var borderColor: UIColor{
        return UIColor(named: "borderColor")!
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
