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
    
//    override init()
//    {
//        super.init(nibName: "OtherViewController", bundle: NSBundle.mainBundle())
//    }
//    
//    required init(coder aDecoder:NSCoder)
//    {
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Other";
        
        
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
