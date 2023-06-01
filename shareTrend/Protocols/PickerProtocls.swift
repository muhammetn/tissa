//
//  PickerProtocls.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 30.04.2022.
//

import UIKit

protocol PickerDelegate{
    func pcickerSelected(row: Int, tableRow: Int, changeSize: Bool, cartId: String, size: Size?)
//    func sizeSelected(row: Int, tableRow: Int)
}
