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
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("obsert:"), name: UPDateUSERORDER, object: nil)
        
        var dataMg = DataManager.getInstance
        dataMg.getAllOrders("ad1ce530g8bzhfi", userId:"1",offset:0)
        
       
        
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

