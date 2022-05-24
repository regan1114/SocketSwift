//
//  TransactionItem.swift
//  SocketSwift
//
//  Created by regan on 2022/5/17.
//

import Foundation

class TransactionItem:NSObject {
    //"e": "trade", // 事件類型
    var eventName:String = ""
    //"E": 123456789, // 事件時間
    var eventUnixTime:Int64 = 0
    //"s": "BNBBTC", // 交易對
    var transactionName:String = ""
    //"t": 12345, // 交易ID
    var transactionID: Int = 0
    //"p": "0.001", // 成交價格
    var price:Float = 0.0
    //"q": "100", // 成交數量
    var quantity:Float = 0.0
    //"b": 88, // 買方的訂單ID
    var buyer:Int = 0
    //"a": 50, // 賣方的訂單ID
    var seller:Int = 0
    //"T": 123456785, // 成交時間
    var time:Int64 = 0
    //"m": true,買方是否是做市方。如true，則此次成交是一個主動賣出單，否則是一個主動買入單。
    var isSellOrder:Bool = false
    //"M": true // 請忽略該字
    var isM:Bool = false
    
    init(text:String){
        if let data = text.data(using: .utf8) {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                //"e": "trade", // 事件類型
                self.eventName = dictionary!["e"] as! String
                //"E": 123456789, // 事件時間
                self.eventUnixTime = dictionary!["E"] as! Int64
                //"s": "BNBBTC", // 交易對
                self.transactionName = dictionary!["s"] as! String
                //"t": 12345, // 交易ID
                self.transactionID = dictionary!["t"] as! Int
                //"p": "0.001", // 成交價格
                let priceString = dictionary!["p"] as! String
                self.price = Float(priceString)!
                //"q": "100", // 成交數量
                let quantityString = dictionary!["q"] as! String
                self.quantity = Float(quantityString)!
                //"b": 88, // 買方的訂單ID
                self.buyer = dictionary!["b"] as! Int
                //"a": 50, // 賣方的訂單ID
                self.seller = dictionary!["a"] as! Int
                //"T": 123456785, // 成交時間
                self.time = dictionary!["T"] as! Int64
                //"m": true,買方是否是做市方。如true，則此次成交是一個主動賣出單，否則是一個主動買入單。
                self.isSellOrder = dictionary!["m"] as! Bool
                //"M": true // 請忽略該字
                self.isM = dictionary!["M"] as! Bool
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    init(dictionary:[String:Any]){
        //"e": "trade", // 事件類型
        self.eventName = dictionary["e"] as! String
        //"E": 123456789, // 事件時間
        self.eventUnixTime = dictionary["E"] as! Int64
        //"s": "BNBBTC", // 交易對
        self.transactionName = dictionary["s"] as! String
        //"t": 12345, // 交易ID
        self.transactionID = dictionary["t"] as! Int
        //"p": "0.001", // 成交價格
        let priceString = dictionary["p"] as! String
        self.price = Float(priceString)!
        //"q": "100", // 成交數量
        let quantityString = dictionary["q"] as! String
        self.quantity = Float(quantityString)!
        //"b": 88, // 買方的訂單ID
        self.buyer = dictionary["b"] as! Int
        //"a": 50, // 賣方的訂單ID
        self.seller = dictionary["a"] as! Int
        //"T": 123456785, // 成交時間
        self.time = dictionary["T"] as! Int64
        //"m": true,買方是否是做市方。如true，則此次成交是一個主動賣出單，否則是一個主動買入單。
        self.isSellOrder = dictionary["m"] as! Bool
        //"M": true // 請忽略該字
        self.isM = dictionary["M"] as! Bool
    }
}

