//
//  SQLFile.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 09.05.2022.
//

import SQLite

class SqlFile
{
    public static var dataBase: Connection! = nil
    public static var productTable = Table("product")
    public static var id = Expression<String>("id")
    public static var title = Expression<String>("title")
    public static var salePrice = Expression<Double>("salePrice")
    public static var price = Expression<Double>("price")
    public static var image = Expression<String>("image")
    public static var brand = Expression<String>("brand")
    public static var getProductUrl = Expression<String>("getProductUrl")
    
    static func createTable(){
        let createTable = self.productTable.create(ifNotExists: true) { t in
            t.column(self.id, unique: true)
            t.column(self.title)
            t.column(self.salePrice)
            t.column(self.price)
            t.column(self.image)
            t.column(self.brand)
            t.column(self.getProductUrl)
        }
        do {
            try self.dataBase.run(createTable)
            print("ProductId Table created")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func addProduct(product: Product){
        let products = takeAllProduct()
        if (products?.count ?? 0) < 35 {
            let insert = productTable.insert(id<-product.slug ?? "",
                                             title<-product.name ?? "",
                                             salePrice<-product.sale_price ?? 0,
                                             price<-product.price ?? 0,
                                             image<-product.images?.first?.medium ?? "",
                                             brand<-product.brand ?? "",
                                             getProductUrl<-product.getProductUrl ?? ""
            )
            do{
                try dataBase.run(insert)
                print("inserted")
            }catch{
                print(error.localizedDescription)
            }
        }else{
            guard let last = products?.first?.slug else {return}
            deleteById(productId: last)
        }
    }

    
    static func checkIfExist(_ productId: String)->Row?{
        do {
            let query = self.productTable.filter(id == productId)
            let data = try dataBase.pluck(query)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func deleteById(productId:String){
        do{
            let product = self.productTable.filter(id == productId)
            try dataBase.run(product.delete())
            print("removed")
        }
        catch{
            print("Get by Id Error : \(error.localizedDescription)")
        }
    }
    
    static func takeAllProduct()-> [RandomProduct]?{
        do {
            var products = [RandomProduct]()
            for product in try dataBase.prepare(productTable){
                var myProduct = RandomProduct()
                myProduct.slug = product[id]
                myProduct.name = product[title]
                myProduct.sale_price = product[salePrice]
                myProduct.price = product[price]
                myProduct.image = product[image]
//                myProduct.brand = product[brand]
                myProduct.url = product[getProductUrl]
                products.append(myProduct)
            }
            return products
        } catch {
            print(error)
            return nil
        }
    }
}
