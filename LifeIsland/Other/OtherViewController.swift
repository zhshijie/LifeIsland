//
//  OtherViewController.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/6.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController,UINavigationControllerDelegate{

    var otherRootNav:UINavigationController?
    var rootVC:UIViewController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "其他";
        self.navigationController?.delegate = self
      
        
    }
    
  
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed
        {
            (self.tabBarController as! BaseViewController).hideTabBar()
        }else
        {
            (self.tabBarController as! BaseViewController).unHideTabBar()
        }
    }

    
    override func viewWillAppear(animated: Bool) {
//        var tab = self.tabBarController! as! BaseViewController
        self.hidesBottomBarWhenPushed = false
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
