//
//  UserManager.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/8.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

var _userManager = UserManager()
class UserManager: NSObject {
    var  user:User?
    
    /**
    单例模式，获得数据管理类
    
    :returns: 数据管理器
    */
    class var getInstance:UserManager
    {
        _userManager.user = User()
        return _userManager
    }
    
    
    func logInAction(userName:String!,password:String!)->Int
    {
        var logInSuccess  = 0;
        var url = NSURL(string: "http://shenghuodao.gotoip2.com/work/main.php");
        var request =  ASIFormDataRequest(URL:url)
        request.setPostValue(userName, forKey: "user_name")
        request.setPostValue(password, forKey: "password")
        request.setPostValue("user", forKey: "sys")
        request.setPostValue("user", forKey: "ctrl")
        request.setPostValue("login", forKey: "action")
        
        request.setCompletionBlock { () -> Void in
            let responData = request.responseData()
            let  data: AnyObject? = NSJSONSerialization.JSONObjectWithData(responData, options:.MutableLeaves, error:nil)
            
            if data == nil
            {
                print("登陆失败，请重新登录")
                return
            }
            let stauts = (data!.objectForKey("status") as! NSString).integerValue
            logInSuccess = stauts
        }
        return logInSuccess
    }
    
    
    func signAciton(userName:String!,password:String!,repassword:String!,email:String!)
    {
        
    }
}
