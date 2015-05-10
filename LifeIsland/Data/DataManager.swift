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
    var cache:ASIDownloadCache?
    /**
    单例模式，获得数据管理类
    
    :returns: 数据管理器
    */
    class var getInstance:DataManager
    {
       
        return _dataManager
    }
    
    override init() {
        ordersArr = Array<OrderModel>()
        cache = ASIDownloadCache()
    }
    
    
    /**
    获得该用
    户的所有订单
    
    :param: userName 用户名
    :param: userId   用户id
    :param: offset 偏移量
    */
    func getAllOrders(userName:String!,userId:String!,offset:Int!)
    {
        
        let off = "offset=\(offset)"
        
        var urlString = "http://shenghuodao.gotoip2.com/work/main.php?user_name="+userName+"&user_id="+userId+"&sys=lgst&ctrl=lgst_nor&action=scaned_orders&limit=20&"+off
        var url = NSURL(string: urlString);
        
        
        var request =  ASIHTTPRequest(URL:url)
        
        request.requestMethod = "GET"
     
        var path = NSHomeDirectory().stringByAppendingPathComponent("Documents")
        cache!.storagePath = path
        cache!.defaultCachePolicy = ASIOnlyLoadIfNotCachedCachePolicy
        
        request.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy
        request.downloadCache = cache
        
        request.setCompletionBlock { () -> Void in
            
            
            //---------------判断数据的来源:网络 or缓存------------------
            
            if (request.didUseCachedResponse) {
                
                NSLog("数据来自缓存");
                
            } else {
                
                NSLog("数据来自网络");
                
            }
            
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
                
                self.ordersArr!.append(_order)
            }
            
            //发送一个更新用户帐单的通知
            NSNotificationCenter.defaultCenter().postNotificationName(UPDateUSERORDER, object:self.ordersArr)
            
        }
        
        request.setFailedBlock { () -> Void in
            var error = request.error
            print(error)
        }
        
        request.delegate = self
        request.startAsynchronous()
        
    }
    /**
    获得一张特定的订单
    
    :param: userName 用户名
    :param: userId   用户id
    :param: orderId  订单id
    :param: eventId  事件id   扫码事件id是 5
    
    :returns: 返回一张订单数据
    */
    func getTheOrder(userName:String!,userId:String!,orderId:String!,eventId:String!)->OrderModel
    {
        var url = NSURL(string: "http://shenghuodao.gotoip2.com/work/main.php");
        var request =  ASIFormDataRequest(URL:url)
        request.setPostValue(userName, forKey: "user_name")
        request.setPostValue(userId, forKey: "user_id")
        request.setPostValue(orderId, forKey: "order_id")
        request.setPostValue(eventId, forKey: "event_id")
        request.setPostValue("lgst", forKey: "sys")
        request.setPostValue("lgst_nor", forKey: "ctrl")
        request.setPostValue("order_lgst", forKey: "action")
        
        var _order = OrderModel()
        request.setCompletionBlock { () -> Void in
            var responseData = request.responseData()
            
            var error:NSErrorPointer?
            let  AllOrderData: AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData, options:.MutableLeaves, error:nil)
            
            
            if AllOrderData == nil
            {
                print("该用户没有订单")
                return
            }
            
            let orderData:AnyObject? = AllOrderData?.objectForKey("order");
            if orderData != nil
            {
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
            if(AllgoodsData != nil){
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
            }
            }

        }
        
        request.delegate = self
        request.startSynchronous()
        
        return _order
    }
    
    
    /**
    通过商品号，获取商品的数据 采用同步请求
    
    :param: userName 用户名
    :param: userId   用户id
    :param: eventId  事件id
    :param: items    商品号
    
    :returns: 返回商品的所有数据
    */
    func getTheGoods(userName:String!,userId:String!,eventId:String!,items:Array<String>)->Array<GoodsModel>
    {
        var allGoods = Array<GoodsModel>()
        var url = NSURL(string: "http://shenghuodao.gotoip2.com/work/main.php");
        var request =  ASIFormDataRequest(URL:url)
        request.setPostValue(userName, forKey: "user_name")
        request.setPostValue(userId, forKey: "user_id")
        request.setPostValue(eventId, forKey: "event_id")
        request.setPostValue("lgst", forKey: "sys")
        request.setPostValue("lgst_nor", forKey: "ctrl")
        request.setPostValue("items_lgst", forKey: "action")
        
        for i in 0...items.count-1
        {
        request.setPostValue(items[i], forKey: "item_ids[\(i)]")
        }
        
        request.setCompletionBlock { () -> Void in
            var responseData = request.responseData()
            
            var error:NSErrorPointer?
            let  AllOrderData: AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData, options:.MutableLeaves, error:nil)
            
            
            print(request.responseString())
            if AllOrderData == nil
            {
                print("该用户没有订单")
                return
            }
            
            let status = ( AllOrderData!.objectForKey("status") as! NSString ).integerValue
            if status != 0
            {
                print("获取数据失败")
                return
            }
            
            let AllgoodsData:AnyObject? = AllOrderData!.objectForKey("order")!.objectForKey("items")
            if(AllgoodsData != nil){
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
                    allGoods.append(_goods)
                }

        }
        }
        
        request.delegate = self
        request.startSynchronous()
        
        return allGoods
    }
    
    
    /**
    签到时调用的接口  签到时采用同步请求
    
    :param: userName 用户名
    :param: userId   用户id
    :param: regionId 签到地点  通过二维码扫描获得
    */
    func sign(userName:String!,userId:String!,regionId:String!)->Bool
    {
        var signSuccess = false;
        var url = NSURL(string: "http://shenghuodao.gotoip2.com/work/main.php");
        var request =  ASIFormDataRequest(URL:url)
        request.setPostValue(userName, forKey: "user_name")
        request.setPostValue(userId, forKey: "user_id")
        request.setPostValue(regionId, forKey: "region_id")

        request.setPostValue("job", forKey: "sys")
        request.setPostValue("job_epl", forKey: "ctrl")
        request.setPostValue("sign_in", forKey: "action")
        request.setCompletionBlock { () -> Void in
            var responseData = request.responseData()
            
            let  AllOrderData: AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData, options:.MutableLeaves, error:nil)

            if AllOrderData == nil
            {
                print("签到失败，请重新签到")

            }else{
                let status:Int = (AllOrderData!.objectForKey("status") as? NSString)!.integerValue
                if status == 0
                {
                    signSuccess = true
                }
            }

        }
        
        request.setFailedBlock { () -> Void in
            var error = request.error
            print(error)

        }
        request.delegate = self
        request.startSynchronous()
        return signSuccess
    }
    
    /**
    JSON格式转换
    
    :param: jsonString json字符串
    
    :returns: 解析的内容
    */
    func JsonStringToDiction(jsonString:String!)->AnyObject?
    {
        var data = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let  AllOrderData: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options:.MutableLeaves, error:nil)
      
        return AllOrderData
    }
    
    
    /**
    将账单缓存到本地
    */
    func OrderDataCache()
    {
        var ud = NSUserDefaults.standardUserDefaults()
        var archdata = NSKeyedArchiver.archivedDataWithRootObject(self.ordersArr!)
        ud.setObject(archdata, forKey: "orderArr")
        
    }
    
    /**
    从本地中获得缓存的账单

    
    :returns: 如果本地有数据，则返回true，否则则返回false
    */
    func GetOrderFromCache()->Bool
    {
        var ud = NSUserDefaults.standardUserDefaults()
        var unarchdata:NSData? = ud.objectForKey("orderArr") as? NSData
        if unarchdata != nil
        {
        var data:Array<OrderModel>? = NSKeyedUnarchiver.unarchiveObjectWithData(unarchdata!) as? Array<OrderModel>
        self.ordersArr = data;
            
            return true
        }
        return false
    }
    
    
}
