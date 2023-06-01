//
//  Network.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 04.05.2022.
//

import UIKit
import Alamofire

class Network {
    
    public static let shared = Network()
//    var BASE_URL = host
//    var BASE_URL = "http://45.90.33.134:3130/"
//    var BASE_URL = "https://api.sebedim.site/"
    var BASE_URL = "http://95.85.126.192:3130/"
    var appVersion = "1.0.0"
    init() {}
    
    func getHomeBanners(networkError: @escaping(String)->(), success: @escaping([Banner])->()){
        let url = "\(BASE_URL)api/get-home-banners"
        let request = URLRequest(url: URL(string: url)!)
        AF.request(request).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(GetHomeBannerResponse.self, from: data)
                    if result.error ?? true{
                        networkError(result.message?.text ?? "")
                    }else{
                        success(result.body ?? [])
                    }
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func startVerification(phone: String, networkError: @escaping(String)->(), success: @escaping(String)->()){
        let url = "\(BASE_URL)api/start-verification"
        print(url)
        let params: [String: Any] = [
            "phone": phone
        ]
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(CheckResponse.self, from: data)
                    if result.error ?? true{
                        networkError(result.message?.text ?? "")
                    }else{
                        success(result.body ?? "")
                    }
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func signup(phone: String, invite_code: String?, fullname: String, address: String, email: String?, code: String, networkError: @escaping(String)->(), success: @escaping(User)->()) {
        let url = "\(BASE_URL)api/user-signup"
        var params: [String: Any] = [
            "phone": phone,
            "fullname": fullname,
            "address": address,
            "code": code
        ]
        
        if let mail = email {
            params["email"] = mail
        }
        if let invite_code = invite_code {
            params["token"] = invite_code
            print("TOKEN: \(invite_code)")
        }
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(SignupResponse.self, from: data)
                    guard let user = result.body else {networkError(result.message?.text_ru ?? "Error"); return}
                    success(user)
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func getUserFullname(token: String, networkError: @escaping(String)->(), success: @escaping(String)->()){
        let url = "\(BASE_URL)api/get-user-fullname?token=\(token)"
        print(url)
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        AF.request(request).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(GetUserFullname.self, from: data)
                    success(result.body ?? "")
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func signin(phone: String, code: String, networkError: @escaping(String)->(), success: @escaping(User)->()){
        let url = "\(BASE_URL)api/user-signin"
        let params: [String: Any] = [
            "phone": phone,
            "code": code,
        ]
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(SignupResponse.self, from: data)
                    guard let user = result.body else {networkError(result.message?.text_ru ?? "Error");return}
                    success(user)
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func getProduct(product: String, networkError: @escaping(String)->(), success: @escaping(Product)->()){
//        guard let token = UserDefaults.standard.string(forKey: "token") else {networkError("No token"); return}
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = "\(BASE_URL)api/get-product"
        let params: [String: Any] = [
            "url": product
        ]
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data {
                do {
                    let test = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(test)
                    let json = JSONDecoder()
                    let result = try json.decode(GetProductResponse.self, from: data)
                    guard let product = result.body else { networkError(result.message?.text_ru ?? "can_not_find_product".localized()); return }
                    success(product)
                } catch {
                    print(error.localizedDescription)
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    
    func addToCart(product: Product, size: Size, networkError: @escaping(String)->(), success: @escaping()->()){
        guard let token = UserDefaults.standard.string(forKey: "token") else {networkError("No token"); return}
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        let url = "\(BASE_URL)api/add-to-cart"
        let params: [String: Any] = [
            "url": product.url ?? "",
            "image": (product.images?.first?.medium ?? ""),
            "name": product.name ?? "",
            "price": product.price ?? 0,
            "sale_price": size.sale_price ?? 0,
            "origin_price": size.origin_price ?? 0,
            "slug": product.slug ?? "",
            "storefrontId": product.storefrontId?.stringValue ?? "",
            "contentId": product.contentId?.stringValue ?? "",
            "count": 1,
            "size": size.value ?? "",
            "itemNumber": size.itemNumber ?? 0,
            "barcode": size.barcode ?? ""
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(AddCartResponse.self, from: data)
                    if result.error ?? true{
                        networkError(result.message?.text_ru ?? "Error add cart")
                    }else{
                        success()
                    }
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func getUserCart(networkError: @escaping(String)->(), success: @escaping(Cart)->()){
        guard let token = UserDefaults.standard.string(forKey: "token") else {networkError("No token"); return}
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        let url = "\(BASE_URL)api/get-user-cart"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.headers = headers
        AF.request(request).responseJSON { response in
            if let error = response.error {
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(GetUserCart.self, from: data)
                    if result.error ?? true {
                        networkError(result.message?.text_ru ?? "")
                    }else {
                        success(result.body ?? Cart())
                    }
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func checkProduct(networkError: @escaping(String)->(), success: @escaping([Product])->()){
        guard let token = UserDefaults.standard.string(forKey: "token") else {networkError("No token"); return}
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        let url = "\(BASE_URL)api/check-product"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .post
        request.headers = headers
        AF.request(request).responseJSON { response in
            if let error = response.error {
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(CheckProductResponse.self, from: data)
                    if result.error ?? true {
                        networkError(result.message?.text_ru ?? "")
                    }else {
                        success(result.body ?? [])
                    }
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    
    func setCartCount(cartId: String, count: String, networkError: @escaping(String)->(), succuss: @escaping()->()){
        guard let token = UserDefaults.standard.string(forKey: "token") else {networkError("No token"); return}
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        let url = "\(BASE_URL)api/set-cart-count"
        let params: [String: Any] = [
            "count": count,
            "cart_id": cartId,
        ]
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(CheckResponse.self, from: data)
                    if result.error ?? true {
                        networkError(result.message?.text_ru ?? "")
                    }else {
                        succuss()
                    }
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func createUserOrder(cargo_type: Int, selected: [String]?, networkError: @escaping(String)->(), success: @escaping()->()){
        guard let token = UserDefaults.standard.string(forKey: "token") else {networkError("No token"); return}
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        let url = "\(BASE_URL)api/create-user-order"
        let date = NSDate() // current date
        let unixtime = date.timeIntervalSince1970
        var params: [String: Any] = [
            "ctime": unixtime,
            "cargo_type": cargo_type
        ]
        if selected != nil && (selected?.count ?? 0) > 0 {
            let carts = selected?.joined(separator: ",")
            params["selected"] = carts
        }
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
//                print(response.response)
//                print(response.result)
//                print(response.value)
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(CreateUserOrder.self, from: data)
                    if result.error ?? true{
                        networkError(result.message?.text_ru ?? "Error")
                    }else{
                        success()
                    }
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func getOrders(page: Int, networkError: @escaping(String)->(), success: @escaping(GetUserOrdersResponse)->()){
        guard let token = UserDefaults.standard.string(forKey: "token") else { networkError("No token"); return }
        let url = URL(string: "\(BASE_URL)api/get-user-orders?page=\(page)&per_page=10")!
        var request = URLRequest(url: url)
        request.method = .get
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        request.headers = headers
        
        AF.request(request).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                
//                    print(response.response)
//                    print(response.result)
//                    print(response.value)
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(GetUserOrdersResponse.self, from: data)
                    if result.error ?? true {
                        networkError(result.message?.text_ru ?? "")
                        return
                    }
                    success(result)
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func getOrder(orderId: String, networkError: @escaping(String)->(), success: @escaping(GetUserOrderResponse)->()){
        guard let token = UserDefaults.standard.string(forKey: "token") else {networkError("no token"); return}
        let url = URL(string: "\(BASE_URL)api/get-user-order?order_id=\(orderId)")!
        var request = URLRequest(url: url)
        request.method = .get
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        request.headers = headers
        AF.request(request).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(GetUserOrderResponse.self, from: data)
                    if result.error ?? true { networkError(result.message?.text_ru ?? ""); return }
                    success(result)
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func modifyCartSize(size: Size, cartId: String,  networkError: @escaping(String)->(), success: @escaping()->()){
        guard let token = UserDefaults.standard.string(forKey: "token") else {networkError("no token"); return}
        let url = "\(BASE_URL)api/modify-cart-size"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        let params: [String: Any] = [
            "price": 0,
            "sale_price": size.sale_price ?? 0,
            "origin_price": size.origin_price ?? 0,
            "cart_id": cartId,
            "size": size.value ?? "",
            "itemNumber": size.itemNumber ?? 0,
            "barcode": size.barcode ?? ""
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(AddCartResponse.self, from: data)
                    if result.error ?? true { networkError(result.message?.text_ru ?? ""); return }
                    success()
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func cancelOrders(order_id: String, networkError: @escaping(String)->(), success: @escaping()->()){
        guard let token = UserDefaults.standard.string(forKey: "token") else {networkError("no token"); return}
        let url = "\(BASE_URL)api/cancel-ordered-products-all-available"
        let params: [String: Any] = [
            "order_id": order_id
        ]
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(CreateUserOrder.self, from: data)
                    if result.error ?? true {
                        networkError(result.message?.text_ru ?? "Error canceling orders")
                    }else{
                        success()
                    }
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func cancelOrder(od_id: String, networkError: @escaping(String)->(), success: @escaping()->()){
        guard let token = UserDefaults.standard.string(forKey: "token") else {networkError("no token"); return}
        let url = "\(BASE_URL)api/cancel-ordered-products-all-available"
        let params: [String: Any] = [
            "od_id": od_id
        ]
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(CreateUserOrder.self, from: data)
                    if result.error ?? true {
                        networkError(result.message?.text_ru ?? "Error canceling orders")
                    }else{
                        success()
                    }
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func getConstantPage(page: String, networkError: @escaping(String)->(), success: @escaping(ConstantPage)->()){
        let url = "\(BASE_URL)api/get-page?page=\(page)&lang_code=\(lang)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        
        AF.request(request).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(GetPage.self, from: data)
                    if result.error ?? true {
                        networkError(result.message?.text_ru ?? "")
                    }else{
                        guard let body = result.body else {return}
                        success(body)
                    }
                } catch {
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func ping(networkError: @escaping(String)->(), success: @escaping(PingResponse)->()){
        let url = "\(BASE_URL)api/ping"
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        let params: [String: Any] = [
            "appVersion": appVersion,
            "device": modelCode ?? "unrecognized",
            "os": "iOS \(UIDevice.current.systemVersion)",
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(PingResponse.self, from: data)
                    if result.error ?? true{
                        networkError(result.message?.text_ru ?? "error")
                    }else{
                        success(result)
                    }
                } catch {
                    print(error.localizedDescription)
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func getProducts(networkError: @escaping(String)->(), success: @escaping(RandomProducts)->()){
        let url = "\(BASE_URL)api/get-products"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        AF.request(request).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
//                    let test = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(test)
                    let json = JSONDecoder()
                    let result = try json.decode(GetProductsResponse.self, from: data)
                    if result.error ?? true {
                        networkError(result.message?.text_ru ?? "error")
                    }else{
                        guard let body = result.body else {return networkError("network_error")}
                        success(body)
                    }
                } catch {
                    print(error.localizedDescription)
                    networkError("network_error".localized())
                }
            }
        }
    }
    
    func deleteUser(networkError: @escaping(String)->(), success: @escaping()->()){
        let url = URL(string: "https://api.sebedim.site/api/delete-user")!
        guard let token = UserDefaults.standard.string(forKey: "token") else { return networkError("no token")}
        let params: [String: String] = [
            "token": token
        ]
        AF.request(url, method: .delete, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            if let error = response.error{
                print(error.localizedDescription)
                networkError("network_error".localized())
            }
            if let data = response.data{
                do {
                    let json = JSONDecoder()
                    let result = try json.decode(CheckResponse.self, from: data)
                    if (result.error ?? true){
                        networkError("network_error".localized())
                    }else{
                        success()
                    }
                } catch {
                    print(error.localizedDescription)
                    networkError("network_error".localized())
                }
            }
        }
        
    }
}

