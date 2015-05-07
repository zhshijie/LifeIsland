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
class OrderModel: NSObject {
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
    
}
