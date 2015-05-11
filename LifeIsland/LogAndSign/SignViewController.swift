//
//  SignViewController.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/11.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {


    
    var alertView:UIAlertView?
    
    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var repasswordTextTield: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    
    @IBAction func submitAction(sender: AnyObject) {
        
        
        if userNameTextField.text.isEmpty || passwordTextField.text.isEmpty || repasswordTextTield.text.isEmpty || emailTextField.text.isEmpty{
            alertView!.message = "请填好所有的内容"
            alertView!.show()
             NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:Selector("dissMissAlert"), userInfo:nil, repeats: false)
            
        }
        else{
            var userMg = UserManager.getInstance
            var status = userMg.signAciton(userNameTextField.text, password: passwordTextField.text, repassword:repasswordTextTield.text, email: emailTextField.text, subPin:"zxtd")
            
            if status == 0
            {
                self.SignSuccess()
            }else
            {
                
                var message = ""
                switch status
                {
                case 1: message = "用户名为空"
                case 2: message = "密码须6个以上"
                case 3: message = "邮箱格式错误"
                case 4: message = "两次密码输入不正确"
                case 5: message = "验证码错误"
                case 6: message = "邮箱已注册"
                case 7: message = "用户已被他人注册"
                default: message = "未知错误，请重新登录"
                }
                
              alertView!.message = message
                alertView!.show()
                NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:Selector("dissMissAlert"), userInfo:nil, repeats: false)
            }
            
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
    
    func SignSuccess()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 109/255, green: 137/255, blue: 190/255, alpha:1)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        alertView = UIAlertView()
        alertView!.title = "注册"

        self.title = "注册"
        // Do any additional setup after loading the view.
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
