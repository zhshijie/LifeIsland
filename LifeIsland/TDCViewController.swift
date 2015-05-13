//
//  TDCViewController.swift
//  LifeIsland
//
//  Created by Caesar on 15/5/8.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
class TDCViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate{

    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let session = AVCaptureSession()
    var layer: AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "二维码扫描"
        self.view.backgroundColor = UIColor.grayColor()
        let labIntroudction = UILabel(frame:CGRectMake(15, 80, 290, 50))
        labIntroudction.backgroundColor = UIColor.clearColor()
        labIntroudction.numberOfLines = 2
        labIntroudction.textColor = UIColor.whiteColor()
        labIntroudction.text = "将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。"
        self.view.addSubview(labIntroudction)
        let imageView = UIImageView(frame:CGRectMake(UIScreen.mainScreen().bounds.size.width/2-150, UIScreen.mainScreen().bounds.size.height/2-150, 300, 300))
        imageView.image = UIImage(named:"pick_bg")
        self.view.addSubview(imageView)
        
        
     }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupCamera()
        self.session.startRunning()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func setupCamera(){
        self.session.sessionPreset = AVCaptureSessionPresetHigh
        var error : NSError?
        let input = AVCaptureDeviceInput(device: device, error: &error)
        if (error != nil) {
            println(error!.description)
            return
        }
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        //验证码框
        layer = AVCaptureVideoPreviewLayer(session: session)
        layer!.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer!.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width/2-140, UIScreen.mainScreen().bounds.size.height/2-140, 280, 280)
        self.view.layer.insertSublayer(self.layer, atIndex: 0)
        
        let output = AVCaptureMetadataOutput()


        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
            

        }
           session.startRunning()
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!){
        var stringValue:String?
        if metadataObjects.count > 0 {
            var metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }
        self.session.stopRunning()
        println("code is \(stringValue)")
        
        var alertView = UIAlertView()
        alertView.delegate=self
        alertView.title = "扫描"
//        alertView.message = "扫到的二维码内容为:\(stringValue)"
        
        let range = NSMakeRange(0,2)
        let subString = (stringValue! as NSString).substringWithRange(range)  //子字符串
        if subString == "02"
        {
            
            if UserManager.getInstance.user?.jcatId == nil
            {
                var alert = UIAlertView(title: "签到", message: "请先进行签到", delegate: nil, cancelButtonTitle:"确定")
                alert.show()
            }
            else
            {
                var user = UserManager.getInstance.user
                self.sendMessageToNetWork(user?.userName!, userId: "\(user?.id!)", orderId:"", eventId: user?.jcatId!, orderCode: subString)
            }
            session.stopRunning()
            self.setupCamera()
            self.session.startRunning()

        }
        else{
            
        //json解析数据
        var jsonstr :NSDictionary? = DataManager.getInstance.JsonStringToDiction(stringValue) as? NSDictionary
        var regionId :String? = jsonstr?.objectForKey("region_id") as? String
//        
//        if jsonstr == nil{
//            alertView.message = "扫描失败，请扫描正确的图案"
//            alertView.addButtonWithTitle("确认")
//        }
           
        var userMg = UserManager.getInstance
        self.signActio(userMg.user!.userName, userId:"\(userMg.user?.id)", regionId: regionId)
        }
//        alertView.show()
        
       
        
        
    }
    //弹出框方法
     func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
//        self.navigationController!.popViewControllerAnimated(true)
        self.setupCamera()
        self.session.startRunning()
        
    }
    
    /**
    发送订单
    
    :param: userName  用户名
    :param: userId    用户id
    :param: orderId   账单id
    :param: eventId   事件id
    :param: orderCode 账单号
    */
    func sendMessageToNetWork(userName: String!, userId: String!, orderId: String!, eventId: String!,orderCode:String!)
    {
       if  DataManager.getInstance.getTheOrder(userName, userId: userId, orderId: orderId, eventId: eventId ,orderCode:orderCode)
        {
        
        }else
       {
        var alert = UIAlertView(title: "订单扫描", message: "订单扫描失败，请重新扫描", delegate: nil, cancelButtonTitle:"确定")
        alert.show()
        }
    }
    
    /**
    签到
    
    :param: userName 用户名
    :param: userId   用户id
    :param: regionId 签到id
    */
    func signActio(userName: String!, userId: String!, regionId: String!)
    {
       if  DataManager.getInstance.sign(userName, userId: userId, regionId: regionId)
       {
        var alert = UIAlertView(title: "签到", message: "签到成功", delegate: nil, cancelButtonTitle:"确定")
        alert.show()
        self.navigationController!.popViewControllerAnimated(true)
        }else
       {
        var alert = UIAlertView(title: "签到", message: "签到失败,请重新签到", delegate: nil, cancelButtonTitle:"确定")
        alert.show()
        session.stopRunning()
        self.setupCamera()
        self.session.startRunning()

        }
        
    }
    
    

}
