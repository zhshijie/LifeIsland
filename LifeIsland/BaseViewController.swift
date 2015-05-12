//
//  BaseViewController.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/11.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

class BaseViewController: UITabBarController {

    
    var buttons:[UIButton]?
    var Images:[UIImageView]?
    var selected:[UIImage]?
    var normal:[UIImage]?
    
    var Image1:UIImageView?
    var Image2:UIImageView?
    var Image3:UIImageView?
    
    var TabBar:UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = Array<UIButton>()
        Images = Array<UIImageView>()
        selected = Array<UIImage>()
        normal = Array<UIImage>()
        
        self.hideRealTabBar()
        self.customTabBar()

        // Do any additional setup after loading the view.
    }
    
    
    
   
    
    
    func hideRealTabBar()
    {
        for view in self.view.subviews
        {
            if view is UITabBar
            {
                (view as! UITabBar).hidden = true
            }
        }
    }
    
    func customTabBar()
    {
        
        
        TabBar = UIView(frame:self.tabBar.frame)
        self.view.addSubview(TabBar!)
        var screenFrame = UIScreen.mainScreen().bounds
        
        var Image1_select = UIImage(named:"图标cc-35.png")
        var Image2_select = UIImage(named:"图标cc-34.png")
        var Image3_select = UIImage(named:"图标cc-31.png")
        
        selected!.append(Image1_select!)
        selected!.append(Image2_select!)
        selected!.append(Image3_select!)

        
        var Image1_normal = UIImage(named:"图标cc-33.png")
        var Image2_normal = UIImage(named:"图标cc-32.png")
        var Image3_normal = UIImage(named:"图标cc-36.png")
        
        normal!.append(Image1_normal!)
        normal!.append(Image2_normal!)
        normal!.append(Image3_normal!)

         Image1 =  UIImageView(image:Image1_select)
         Image2 =  UIImageView(image: UIImage(named:"图标cc-32.png"))
         Image3 =  UIImageView(image: UIImage(named:"图标cc-36.png"))
        
        
      
    
        
        Image1!.frame = CGRect(x: 0, y:0, width:self.tabBar.frame.size.width/3, height: self.tabBar.frame.size.height);
        Image2!.frame = CGRect(x:self.tabBar.frame.size.width/3 , y:0, width:self.tabBar.frame.size.width/3, height: self.tabBar.frame.size.height);
        Image3!.frame = CGRect(x:self.tabBar.frame.size.width/3*2 , y:0, width:self.tabBar.frame.size.width/3, height: self.tabBar.frame.size.height);
        
        TabBar!.addSubview(Image1!)
        TabBar!.addSubview(Image2!)
        TabBar!.addSubview(Image3!)
        
        Images!.append(Image1!)
         Images!.append(Image2!)
         Images!.append(Image3!)
        
      
        var size  = CGSize(width:Image1!.frame.size.width/3, height:Image1!.frame.size.width/3)
        var center1 = CGSize(width: Image1!.frame.size.width/2,height: Image1!.frame.size.height/2)
        var  frame1 = CGRect(x: center1.width - size.width/2 + Image1!.frame.origin.x, y: center1.height - size.height/2 +  Image1!.frame.origin.y, width:size.height , height: size.height)
        var button1 = UIButton(frame:frame1)
        button1.tag = 0
        button1.setImage(UIImage(named:"图标cc-01.png"), forState: .Normal)
        button1.addTarget(self, action: Selector("selectedTab:"), forControlEvents: .TouchUpInside)
        TabBar!.addSubview(button1)
        buttons!.append(button1)
        
        
        var center2 = CGSize(width: Image2!.frame.size.width/2,height: Image2!.frame.size.height/2)
        var  frame2 = CGRect(x: center2.width - size.width/2 + Image2!.frame.origin.x, y: frame1.origin.y, width:size.height , height: size.height)
        
        var button2 = UIButton(frame:frame2)
        button2.tag = 1
        button2.setImage(UIImage(named:"图标cc-02.png"), forState: .Normal)
        button2.addTarget(self, action: Selector("selectedTab:"), forControlEvents: .TouchUpInside)

        TabBar!.addSubview(button2)
        buttons!.append(button2)
        
        
        var center3 = CGSize(width: Image3!.frame.size.width/2,height: Image3!.frame.size.height/2)
        var  frame3 = CGRect(x: center3.width - size.width/2 + Image3!.frame.origin.x, y: frame1.origin.y, width:size.height , height: size.height)
        var button3 = UIButton(frame:frame3)
        button3.tag = 2
        button3.setImage(UIImage(named:"图标cc-03.png"), forState: .Normal)
        button3.addTarget(self, action: Selector("selectedTab:"), forControlEvents: .TouchUpInside)
        TabBar!.addSubview(button3)
        buttons!.append(button3)
        
        
        
    }
    
    
    func selectedTab(button:UIButton)
    {
        if self.selectedIndex == button.tag
        {
            
        }
        
        var beforImage:UIImageView = Images![self.selectedIndex] as UIImageView
        
        beforImage.image = normal![self.selectedIndex]
        self.selectedIndex = button.tag
        
        var currentImage:UIImageView = Images![self.selectedIndex] as UIImageView
        currentImage.image = selected![self.selectedIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func hideTabBar()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.35)
        
        TabBar!.frame = CGRect(x: -self.view.frame.size.width,y: TabBar!.frame.origin.y,width: TabBar!.frame.size.width,height: TabBar!.frame.size.height)
        
        UIView.commitAnimations()
    }
    

    func unHideTabBar()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.35)
        
        TabBar!.frame = CGRect(x:0,y: TabBar!.frame.origin.y,width: TabBar!.frame.size.width,height: TabBar!.frame.size.height)
        
        UIView.commitAnimations()
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.selectedViewController?.beginAppearanceTransition(true, animated: animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.selectedViewController?.endAppearanceTransition()
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.selectedViewController?.endAppearanceTransition()

    }
    
    override func viewWillDisappear(animated: Bool) {
           self.selectedViewController?.beginAppearanceTransition(false, animated: animated)
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
