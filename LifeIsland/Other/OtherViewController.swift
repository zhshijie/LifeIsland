//
//  OtherViewController.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/6.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {

    var otherRootNav:UINavigationController?
    var rootVC:UIViewController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Other";
        
        if hasUserLogIning() == false
        {
            PresentToLogInView()
        }
    
        
    }

    /**
    是否用户已经登录
    
    :returns: 如果已经登录返回true
    */
    func hasUserLogIning()->Bool
    {
        var hasLog = false
        var userMg = UserManager.getInstance
        
        userMg.GetUserNameFormCache()
        if userMg.user!.userName != nil {
            
            userMg.GetUserDataFromCache(userMg.user!.userName)
            
            if userMg.user!.id  == nil
            {
                hasLog = false
            }else{
                hasLog = true
            }
        }else
        {
            hasLog = false
        }
        return hasLog
    }
    
    /**
    跳转到登录界面
    */
    func PresentToLogInView()
    {
        var log = LogInViewController(nibName:"LogInViewController",bundle:nil)
        log.view.frame = UIScreen.mainScreen().bounds
        var nav = UINavigationController(rootViewController: log)
        nav.navigationBar.tintColor = UIColor.whiteColor()
        self.presentViewController(nav, animated: true, completion: nil)
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
