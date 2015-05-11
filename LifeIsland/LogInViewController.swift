//
//  LogInViewController.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/11.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var LogInButton: UIButton!
    
    var activityIV:UIActivityIndicatorView?
    var alertView:UIAlertView?
  
    @IBAction func LogInButtonAction(sender: UIButton) {
        

        if !userNameTextField.text.isEmpty
        {
            if !passwordTextField.text.isEmpty
            {
                alertView!.title = "登录"
                alertView!.message = "正在登录..."
                alertView!.show()
                var status =  UserManager.getInstance.logInAction(userNameTextField.text, password: passwordTextField.text)
                
                self.dissMissAlert()
                if status == 0
                {
                    print("登录成功")
                    
                    
                    alertView!.message = "正在获取数据..."
                    alertView!.title = "登录"

                    alertView!.show()
                    var userMg = UserManager.getInstance
                    var result = userMg.getUserDataFromNetwork(userMg.user!.userName!,userId:userMg.user!.id!)
                    if result == 0
                    {
                        print("获取数据成功")
                        self.dissMissAlert()
                        self.LogInSuccess()
                    }else
                    {
                        alertView!.message = "获取用户数据失败,请重新登录"
                        print("获取数据失败")
                        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:Selector("dissMissAlert"), userInfo:nil, repeats: false)
                        
                    }
                    
                }
                else{
                    var message = ""
                    switch status
                    {
                    case 1: message = "请完善自己的个人信息"
                    case 2: message = "密码错误"
                    case 3: message = "用户名不存在"
                    default: message = "未知错误，请重新登录"
                    }
                    
                    alertView!.message = message
                    alertView!.title = "登录"
                    alertView!.show()
                    NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:Selector("dissMissAlert"), userInfo:nil, repeats: false)
                }
                
                
            }
            else
            {
                alertView!.message = "密码不能为空"
                alertView!.title = "登录"
                alertView!.show()
                NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:Selector("dissMissAlert"), userInfo:nil, repeats: false)
            }
        }
        else
        {
            alertView!.message = "用户名不能为空"
            alertView!.title = "登录"
            alertView!.show()
            NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:Selector("dissMissAlert"), userInfo:nil, repeats: false)
        }
        
    }
    /**
    取消提示
    */
    func dissMissAlert()
    {
        
        alertView!.dismissWithClickedButtonIndex(alertView!.cancelButtonIndex, animated: true)
        alertView! = UIAlertView()
    }
    
    /**
    成功登录时加载主页面
    */
    func LogInSuccess()
    {
        
        var  RootTaB = UITabBarController()
        var CalendarVC = CalendarViewController();
        var ChatVC = ChatViewController();
        var OtherVC = OtherViewController(nibName:"OtherViewController",bundle:nil);
        
        var OtherNav = UINavigationController(rootViewController: OtherVC)
        var CalendarNav = UINavigationController(rootViewController: CalendarVC)
        var ChatNav = UINavigationController(rootViewController: ChatVC)
        RootTaB.setViewControllers([OtherNav,ChatNav,CalendarNav], animated: true);
        
        var appDele:UIApplicationDelegate = UIApplication.sharedApplication().delegate!
       
        appDele.window?!.rootViewController = RootTaB
        
        RootTaB.modalPresentationStyle = .FormSheet
        self.presentViewController(RootTaB, animated: true, completion: nil)
        self.dismissViewControllerAnimated(false, completion: nil)
        self.removeFromParentViewController()
        
    }
   

    @IBAction func SignAction(sender: UIButton) {
        
        var signVC = SignViewController(nibName:"SignViewController",bundle:nil)
        self.navigationController!.pushViewController(signVC, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 109/255, green: 137/255, blue: 190/255, alpha:1)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]

        self.title = "登录"
        alertView = UIAlertView(title:nil, message: nil, delegate: self, cancelButtonTitle:nil)
        

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
