//
//  GoodsModel.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/7.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

/**
*  商品的数据模型
*/
class GoodsModel: NSObject,NSCoding {
    var id:String? //商品的id
    var addTime:String?
    var createTime:String?
    var dishName:String?
    var hotelName:String?
    var price:Float?  //商品价格
    var quantity:Int? //
    var totalPrice:Float? //
    
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(addTime, forKey: "addTime")
        aCoder.encodeObject(createTime, forKey: "createTime")
        aCoder.encodeObject(dishName, forKey: "dishName")
        aCoder.encodeObject(hotelName, forKey: "hotelName")
        aCoder.encodeObject(price, forKey: "price")
        aCoder.encodeObject(quantity, forKey: "quantity")
        aCoder.encodeObject(totalPrice, forKey: "totalPrice")

    }
    required init(coder aDecoder: NSCoder)
    {
        super.init()
        
        id = aDecoder.decodeObjectForKey("id") as? String
        addTime = aDecoder.decodeObjectForKey("addTime") as? String
        createTime = aDecoder.decodeObjectForKey("createTime") as?String
        dishName = aDecoder.decodeObjectForKey("dishName")as? String
        hotelName = aDecoder.decodeObjectForKey("hotelName") as?String
        price = aDecoder.decodeObjectForKey("price") as? Float
        quantity = aDecoder.decodeObjectForKey("quantity") as? Int
        totalPrice = aDecoder.decodeObjectForKey("totalPrice") as? Float
    }
    
    override init() {
        super.init()
    }
    
}
