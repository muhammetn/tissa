//
//  Models.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit

struct ErrorMessage: Codable {
    var text: String?
    var text_ru: String?
}

struct Banner: Codable{
    var banner_id: intOrString?
    var url: String?
    var image: String?
}

struct RandomProducts : Codable{
    var products: [RandomProduct]?
    var total: Int?
}

struct RandomProduct: Codable{
    var prod_id: intOrString?
    var image: String?
    var price: Double?
    var sale_price: Double?
    var url: String?
    var name: String?
    var created_at: String?
    var count: Int?
    var origin_price: Double?
//    var in_stock: Int?
    var slug: String?
    var size: String?
    var storefrontId: intOrString?
    var contentId: intOrString?
    var itemNumber: intOrString?
    var barcode: intOrString?
}

struct User: Codable {
    var fullname: String?
    var phone: String?
    var role: String?
    var email: String?
    var address: String?
    var user_id: intOrString?
    var token: String?
    var inviteCode: String?
}

struct Product: Codable {
    var name: String?
    var images: [Image]?
    var brand: String?
    var in_stock: Bool?
    var price: Double?
    var sale_price: Double?
    var slug: String?
    var storefrontId: intOrString?
    var contentId: intOrString?
    var url: String?
    var sizes: [Size]?
    var imageString: String?
    var getProductUrl: String?
}

struct Image: Codable {
    var large: String?
    var medium: String?
}

struct Size: Codable {
    var index: Int?
    var origin_price: Double?
    var barcode: String?
    var sale_price: Double?
    var value: String?
    var inStock: Int?
    var itemNumber: Int?
}

struct Cart: Codable {
    var meta: Delivery?
    var products: [CartProduct]?
}

struct CartProduct: Codable {
    var cart_id: intOrString?
    var image: String?
    var name: String?
    var price: Double?
    var sale_price: Double?
    var size: String?
    var count: Int?
}

struct Delivery: Codable{
    var express_delivery_day: String?
    var express_delivery_price: String?
    var normal_delivery_day: String?
    var normal_delivery_price: String?
}

struct Order: Codable {
    var order_id: intOrString?
    var created_at: String?
    var delivery_day: Int?
    var status: String?
    var total: Double?
    var shipping_price: Double?
    var products: [OrderProduct]?
    var address: String?
    var phone: String?
    var email: String?
    var receiver: String?
}

struct OrderProduct: Codable{
    var od_id: intOrString?
    var image: String?
    var size: String?
    var price: Double?
    var name: String?
    var status: String?
    var count: Int?
}

struct ConstantPage: Codable {
    var title: String?
    var content: String?
}

enum intOrString: Codable {
    
    case int(Int), string(String)
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        throw QuantumError.missingValue
    }
    
    enum QuantumError:Error {
        case missingValue
    }
}
extension intOrString {
    var stringValue: String? {
        switch self {
        case .string(let value): return value
        case .int(let value): return String(value)
        }
    }
    
    var intValue: Int? {
        switch self {
        case .int(let value): return value
        case .string(let value): return Int(value)
        }
    }
}
