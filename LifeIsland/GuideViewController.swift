//
//  GuideViewController.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/12.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var frame = UIScreen.mainScreen().bounds
        scrollView.contentSize = CGSizeMake(frame.size.width*3, frame.size.height)
        scrollView.frame = frame
        scrollView.scrollEnabled = true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func ToLogInView(sender: AnyObject) {
        var logInView = LogInViewController(nibName:"LogInViewController",bundle:nil)
        
        var logNV = UINavigationController(rootViewController: logInView)
        var appDele:UIApplicationDelegate = UIApplication.sharedApplication().delegate!
        
        
        logNV.modalPresentationStyle = .FormSheet
        logNV.modalTransitionStyle  = .FlipHorizontal
        self.presentViewController(logNV, animated: true) { () -> Void in
            appDele.window?!.rootViewController = logNV
            
        }
        self.removeFromParentViewController()
        


        
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
