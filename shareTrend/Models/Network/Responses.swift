//
//  Responses.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit

struct CheckResponse: Codable{
    var error: Bool?
    var body: String?
    var message: ErrorMessage?
}

struct AddCartResponse: Codable{
    var error: Bool?
//    var body: Int?
    var message: ErrorMessage?
}

struct SignupResponse: Codable {
    var error: Bool?
    var body: User?
    var message: ErrorMessage?
}

struct GetProductResponse: Codable {
    var error: Bool?
    var body: Product?
    var message: ErrorMessage?
}

struct GetUserCart: Codable {
    var error: Bool?
    var body: Cart?
    var message: ErrorMessage?
}

struct CreateUserOrder: Codable {
    var error: Bool?
    var message: ErrorMessage?
}

struct GetUserOrdersResponse: Codable {
    var error: Bool?
    var body: [Order]?
    var message: ErrorMessage?
}


struct GetUserOrderResponse: Codable {
    var error: Bool?
    var body: Order?
    var message: ErrorMessage?
}

struct GetUserFullname: Codable {
    var error: Bool?
    var body: String?
    var message: ErrorMessage?
}

struct CheckProductResponse: Codable {
    var error: Bool?
    var body: [Product]?
    var message: ErrorMessage?
}

struct GetHomeBannerResponse: Codable{
    var error: Bool?
    var body: [Banner]?
    var message: ErrorMessage?
}

struct GetPage: Codable{
    var error: Bool?
    var body: ConstantPage?
    var message: ErrorMessage?
}

struct PingResponse: Codable{
    var error: Bool?
    var body: String?
    var message: ErrorMessage?
    var img: String?
    var src: String?
}

struct GetProductsResponse: Codable{
    var error: Bool?
    var body: RandomProducts?
    var message: ErrorMessage?
}
