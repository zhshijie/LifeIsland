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
        self.hidesBottomBarWhenPushed = false
        
    }
    
  
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        self.tabBarController!.tabBar.hidden = true
        if viewController.hidesBottomBarWhenPushed
        {
            (self.tabBarController as! BaseViewController).hideTabBar()
        }else
        {
            (self.tabBarController as! BaseViewController).unHideTabBar()
        }
    }

    
    @IBAction func ScanningAction(sender: AnyObject) {
        
        var tDC = TDCViewController()
        tDC.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(tDC, animated: true)
        
    }
    
    @IBAction func JobAction(sender: AnyObject)
    {
        var job = JobViewController(nibName: "JobViewController", bundle: nil)
        job.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(job, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
//        var tab = self.tabBarController! as! BaseViewController
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.hidesBottomBarWhenPushed = false
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
