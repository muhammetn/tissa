//
//  doubleExtions.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 24.04.2022.
//

import UIKit

extension Double{
    func rounded(places:Int)->Double{
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
