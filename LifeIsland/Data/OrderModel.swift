//
//  OrderModel.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/7.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

/**
*  订单数据模型
*/
class OrderModel: NSObject,NSCoding {
    var id:String?  //账单的id
    var number:Int? // 账单的序号
    var address:String? //账单的目标地址
    var hasArrived:Bool?  //是否已经送达
    var mobilePhone:String?  //收货者的手机号码
    var addTime:String? //添加时间
    var createTime:String? // 创建时间
    var price:Float? // 账单的总价
    var source:String? // 订单的来源
    var subtotal:Float?  // 小记，即优惠后的价格
    var remarks:String? //备注
    var orderSN:String? //订单号
    var orederCode:String? // 订单码
    var isLock:Bool?
    var isMove:Bool?
    var isOnline:Bool?
    var isPrint:Bool?
    var isNew:Bool?
    var items:Array<GoodsModel>? //账单内的所有商品
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(number, forKey: "number")
        aCoder.encodeObject(address, forKey: "address")
        aCoder.encodeObject(hasArrived, forKey: "hasArrived")
        aCoder.encodeObject(mobilePhone, forKey: "mobilePhone")
        aCoder.encodeObject(addTime, forKey: "addTime")
        aCoder.encodeObject(createTime, forKey: "createTime")
        aCoder.encodeObject(price, forKey: "price")
        aCoder.encodeObject(source, forKey: "source")
        aCoder.encodeObject(subtotal, forKey: "subtotal")
        aCoder.encodeObject(remarks, forKey: "remarks")
        aCoder.encodeObject(orderSN, forKey: "orderSN")
        aCoder.encodeObject(isLock, forKey: "isLock")
        aCoder.encodeObject(isMove, forKey: "isMove")
        aCoder.encodeObject(isOnline, forKey: "isOnline")
        aCoder.encodeObject(isPrint, forKey: "isPrint")
        aCoder.encodeObject(isNew, forKey: "isNew")
        
        if items != nil{
        var itemsData = NSKeyedArchiver.archivedDataWithRootObject(items!)
            aCoder.encodeObject(itemsData, forKey: "items")
        }


        
    }
    required init(coder aDecoder: NSCoder)
    {
        super.init()
        
        id =  aDecoder.decodeObjectForKey("id") as? String
        number = aDecoder.decodeObjectForKey("number") as? Int
        address = aDecoder.decodeObjectForKey("address") as? String
        hasArrived = aDecoder.decodeObjectForKey("hasArrived") as? Bool
        mobilePhone = aDecoder.decodeObjectForKey("mobilePhone") as? String
        addTime = aDecoder.decodeObjectForKey("addTime") as? String
        createTime = aDecoder.decodeObjectForKey("createTime") as? String
        price = aDecoder.decodeObjectForKey("price") as? Float
        source = aDecoder.decodeObjectForKey("source") as? String
        subtotal = aDecoder.decodeObjectForKey("subtotal") as? Float
        remarks = aDecoder.decodeObjectForKey("remarks") as? String
        orederCode = aDecoder.decodeObjectForKey("orederCode") as? String
        orderSN = aDecoder.decodeObjectForKey("orderSN") as? String
        isLock = aDecoder.decodeObjectForKey("isLock") as? Bool
        isMove = aDecoder.decodeObjectForKey("isMove") as? Bool
        isOnline = aDecoder.decodeObjectForKey("isOnline") as? Bool
        isPrint = aDecoder.decodeObjectForKey("isPrint") as? Bool
        
        var itemsData:NSData? = aDecoder.decodeObjectForKey("items") as? NSData
        
        if itemsData != nil{
        items = NSKeyedUnarchiver.unarchiveObjectWithData(itemsData!) as? Array<GoodsModel>
        }


    }
    
    
    override init() {
        super.init()
    }
    
}
