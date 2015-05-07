//
//  DataManager.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/7.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

let _dataManager = DataManager()
class DataManager: NSObject,ASIHTTPRequestDelegate{
   
    var ordersArr: Array<OrderModel>?
    /**
    单例模式，获得数据管理类
    
    :returns: 数据管理器
    */
    class var getInstance:DataManager
    {
        _dataManager.ordersArr = Array<OrderModel>()
        return _dataManager
    }
    
    
    /**
    获得该用
    户的所有订单
    
    :param: userName 用户名
    :param: userId   用户id
    
    :returns:  返回一个数组，存储用户的所有订单
    */
    func getAllOrders(userName:String!,userId:String!,offset:Int!)
    {
        
        var url = NSURL(string: "http://shenghuodao.gotoip2.com/work/main.php");
        var request =  ASIFormDataRequest(URL:url)
        request.setPostValue(userName, forKey: "user_name")
        request.setPostValue(userId, forKey: "user_id")
        request.setPostValue("lgst", forKey: "sys")
        request.setPostValue("lgst_nor", forKey: "ctrl")
        request.setPostValue("scaned_orders", forKey: "action")
        request.setPostValue("20", forKey: "limit");
        request.setPostValue("\(offset)", forKey: "offset");

        
        request.delegate = self
        request.startAsynchronous()
        
    }
    
    
    func requestFinished(request: ASIHTTPRequest!) {
        var responseData = request.responseData()
        
        var error:NSErrorPointer?
        let  AllOrderData: AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData, options:.MutableLeaves, error:nil)
    
        
        if AllOrderData == nil
        {
            print("该用户没有订单")
            return
        }
        
        for   index  in 0...(AllOrderData!.count-1)
        {
            var _order = OrderModel()
            let orderData:AnyObject?  = AllOrderData!.objectAtIndex(index)
            _order.id = orderData!.objectForKey("order_id") as? String
            _order.address = orderData!.objectForKey("address") as? String
            _order.mobilePhone = orderData!.objectForKey("mobile_phone") as? String
            _order.addTime = orderData!.objectForKey("add_time") as? String
            _order.createTime = orderData!.objectForKey("create_time") as? String
            _order.isLock = (orderData!.objectForKey("is_lock") as? NSString)?.boolValue
            _order.isOnline = (orderData!.objectForKey("is_online") as? NSString)?.boolValue
            _order.isPrint = (orderData!.objectForKey("is_print") as? NSString)?.boolValue
            _order.isNew = (orderData!.objectForKey("is_new") as? NSString)?.boolValue
            _order.isMove = (orderData!.objectForKey("is_move") as? NSString)?.boolValue
            _order.number =  (orderData!.objectForKey("order_number") as? NSString)?.integerValue
            _order.price =  (orderData!.objectForKey("price") as? NSString)?.floatValue
            _order.subtotal =  (orderData!.objectForKey("subtotal") as? NSString)?.floatValue
            _order.source = orderData!.objectForKey("source") as? String
            _order.orderSN = orderData!.objectForKey("order_sn") as? String
            _order.remarks = orderData!.objectForKey("remarks") as? String
            _order.orederCode = orderData!.objectForKey("order_code") as? String
            _order.items = Array<GoodsModel>()
            
            let AllgoodsData:AnyObject? = orderData!.objectForKey("order_items")
            for i in 0...(AllgoodsData!.count-1)
            {
                var _goods = GoodsModel()
                let goodsData: AnyObject = AllgoodsData!.objectAtIndex(i)
                _goods.addTime = goodsData.objectForKey("add_time") as? String
                _goods.createTime = goodsData.objectForKey("create_time") as? String
                _goods.dishName = goodsData.objectForKey("dish_name") as? String
                _goods.hotelName = goodsData.objectForKey("hotel_name") as? String
                _goods.id = goodsData.objectForKey("item_id") as? String
                _goods.price = (goodsData.objectForKey("price") as? NSString)?.floatValue
                _goods.quantity = (goodsData.objectForKey("quantity") as? NSString)?.integerValue
                _goods.totalPrice = (goodsData.objectForKey("total_price") as? NSString)?.floatValue
                _order.items?.append(_goods)
            }
            
            ordersArr!.append(_order)
        }
        
        //发送一个更新用户帐单的通知
        NSNotificationCenter.defaultCenter().postNotificationName(UPDateUSERORDER, object:ordersArr)
        
        }
    
    func requestFailed(request: ASIHTTPRequest!) {
        
        var error = request.error
        print(error)
    }
}
