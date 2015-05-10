//
//  ViewController.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/4/30.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var RootTaB:UITabBarController?
    
    func obsert  (noti:NSNotification){
        var data:Array<OrderModel>? = noti.object as? Array<OrderModel>
        
        DataManager.getInstance.OrderDataCache()
        
        print(DataManager.getInstance.GetOrderFromCache())

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//         NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("obsert:"), name: UPDateUSERORDER, object: nil)
//        
//        var dataMg = DataManager.getInstance
////        dataMg.getAllOrders("ad1ce530g8bzhfi", userId:"1",offset:0)
//            if DataManager.getInstance.GetOrderFromCache()
//            {
//                var data:Array<OrderModel> = dataMg.ordersArr!
//                print(data[0].items![0].addTime)
//            
//            }
        
        
        var userMg = UserManager.getInstance
        //登录
//       var stauts =  UserManager.getInstance.logInAction("ddddd", password: "zsj5754295");
//        
//            if stauts == 0
//            {
//                print("userId = \(userMg.user!.id)")
//            }
        
        //注册 其中验证码subPin是固定的
//        var stauts = UserManager.getInstance.signAciton("ddddd", password: "zsj5754295", repassword: "zsj5754295", email: "dddddd@qq.com",subPin:"zxtd")
//        print("statau = \(stauts)")
        
        
        
        
        
        
        
        
        //修改用户信息
//        var status =  UserManager.getInstance.changeUserHeight("ddddd", height: 100)
//         print("statau = \(status)")
//
        print("---------------------\n")
//        print(dataMg.sign("ad1ce530g8bzhfi", userId: "1", regionId: "3774"))v
//        var data:OrderModel = dataMg.getTheOrder("ad1ce530g8bzhfi", userId: "1", orderId: "2271", eventId: "5")
//        
//        print(data.address)
//        dataMg.getTheGoods("ad1ce530g8bzhfi", userId: "1", eventId: "5", items: ["5","4"])
        
        print("\n---------------------\n")
//        
//        var str = "{\"user_name\":\"ad1ce530g8bzhfi\",\"user_id\":\"1\",\"order_id\":\" 2271\",\"event_id\":\"5\",\"sys\":\"lgst\" ,\"ctrl\":\"lgst_nor\",\"action\":\"order_lgst\"}"
//        
//        var data: AnyObject? = dataMg.JsonStringToDiction(str)
//        var data = str.dataUsingEncoding(NSUTF8StringEncoding)
//       
//         let  AllOrderData: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options:.MutableLeaves, error:nil)
//        
//        print(AllOrderData)
//        
        // Do any additional setup after loading the view, typically from a nib.
        RootTaB = UITabBarController()
        var CalendarVC = CalendarViewController();
        var ChatVC = ChatViewController();
        var OtherVC = OtherViewController(nibName:"OtherViewController",bundle:nil);
        
        var OtherNav = UINavigationController(rootViewController: OtherVC)
        var CalendarNav = UINavigationController(rootViewController: CalendarVC)
        var ChatNav = UINavigationController(rootViewController: ChatVC)
        RootTaB!.setViewControllers([OtherNav,ChatNav,CalendarNav], animated: true);
        self.view.addSubview(RootTaB!.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

