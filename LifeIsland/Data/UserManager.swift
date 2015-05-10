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
        return _userManager
    }
    
    
    override init() {
        
        super.init()
        user = User()

    }
    
    /**
    登录接口
    
    :param: userName 用户名
    :param: password 密码
    
    :returns: 返回状态码
    case '0':
				echo "登录成功";
    case '1':
				echo "'跳转到完善个人信息页面'";
    case '2':
				echo "'密码错误！'";
    case '3':
				echo "'用户不存在'";
    */
    func logInAction(userName:String!,password:String!)->Int
    {
        var logInSuccess  = -1;
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
            
            if logInSuccess == 0
            {
                self.user!.id = (data!.objectForKey("user_id") as!NSString).integerValue
                self.user!.userName = userName
            }
        }
        request.delegate = self
        request.startSynchronous()
        return logInSuccess
       
    }
    
    /**
    注册接口
    
    :param: userName   用户名
    :param: password   密码
    :param: repassword 重复密码
    :param: email      邮箱
    :param: subPin      验证码 固定 ＝ zxtd
    
    :returns: 返回一个状态码
    case '0':
    case '1':
				echo '用户名为空';
    case '2':
				echo '密码须6个以上';
    case '3':
				echo '邮箱格式错误';
    case '4':
				echo '两次密码输入不正确';
    case '5':
				echo '验证码错误';
    case '6':
				echo '邮箱已注册';
    case '7':
				echo '用户已被他人注册';
    case '8':
				echo '数据库插入错误';
    case '9':
				echo '数据库更新错误';
    */
    func signAciton(userName:String!,password:String!,repassword:String!,email:String!,subPin:String!)->Int
    {
        
//        var signStauts  = -1;
//
//        var url = NSURL(string: "http://shenghuodao.gotoip2.com/work/main.php");
//        var request =  ASIFormDataRequest(URL:url)
//        request.setPostValue(userName, forKey: "user_name")
//        request.setPostValue(password, forKey: "password")
//        request.setPostValue(repassword, forKey: "repassword")
//        request.setPostValue(subPin, forKey: "sub_PIN")
//        request.setPostValue(email, forKey: "email")
//        request.setPostValue("user", forKey: "sys")
//        request.setPostValue("user", forKey: "ctrl")
//        request.setPostValue("reg", forKey: "action")
//        request.setCompletionBlock { () -> Void in
//            let responseData = request.responseData()
//            let  data: AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData, options:.MutableLeaves, error:nil)
//            
//            if data == nil
//            {
//                print("注册失败，请重新注册")
//                return
//            }
//            
//            let stauts = (data!.objectForKey("status") as! NSString).integerValue
//            
//            signStauts = stauts
//        }
//        request.delegate = self
//        request.startSynchronous()
//        return signStauts
        
        
        
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["password"] = password
        dic["repassword"] = repassword
        dic["sub_PIN"] = subPin
        dic["email"] = email
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "reg"
        
        var status =  sendMessageModel(dic)
        
        if status == 0
        {
            user!.userName = userName
            user!.email = email
        }
        
        return status
        
    }
    
    
    /**
    更改用户密码
    
    :param: userName    用户名
    :param: oldPassword 旧密码
    :param: newPassword 新密码
    :param: repassword  重复新密码
    
    :returns: 返回一个状态码
    case 0:
				echo '更改密码成功';
				break;
    case 1:
				echo "更新密码失败";
				break;
    case 2:
				echo "旧密码错误";
				break;
    */
    func changeUserPassword(userName:String!,oldPassword:String!,newPassword:String!,repassword:String!)->Int
    {
//        var signStauts  = -1;
//        var url = NSURL(string: "http://shenghuodao.gotoip2.com/work/main.php");
//        var request =  ASIFormDataRequest(URL:url)
//        request.setPostValue(userName, forKey: "user_name")
//        request.setPostValue(oldPassword, forKey: "old_password")
//        request.setPostValue(newPassword, forKey: "new_password")
//        request.setPostValue(repassword, forKey: "re_password")
//        request.setPostValue("user", forKey: "sys")
//        request.setPostValue("user", forKey: "ctrl")
//        request.setPostValue("mod_account", forKey: "action")
//        request.setCompletionBlock { () -> Void in
//            let responseData = request.responseData()
//            let  data: AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData, options:.MutableLeaves, error:nil)
//            
//            if data == nil
//            {
//                print("注册失败，请重新注册")
//                return
//            }
//            
//            let stauts = (data!.objectForKey("status") as! NSString).integerValue
//            
//            signStauts = stauts
//        }
        
        
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["old_password"] = oldPassword
        dic["new_password"] = newPassword
        dic["re_password"] = repassword
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_account"
        
        return changeUserData(dic)
    }
    
    //修改用户基本信息接口
    
    //基本信息返回的状态码
    /*
    case '0':
				echo "发布者信息更改成功！";
				break;
    
    case '1':
				echo "发布者信息更改失败！";
				break;
    */
    
    /**
    修改用户信息
    
    :param: user 用户数据模型
    
    :returns: 返回一个状态码
    */
    func changeAllBaseUserData(user:User!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = user.userName
        dic["sex"] = "\(user.sex)"
        dic["tel_phone"] = user.telPhone
        dic["email"] = user.email
        dic["school"] = user.school
        dic["entrance_year"] = "\(user.entranceYear)"
        dic["major"] = user.major
        dic["age"] = "\(user.age)"
        dic["height"] = "\(user.height)"
        dic["figure"] = user.figure
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_basic"
        
        var status =  changeUserData(dic)
        
        if status == 0
        {
            self.user!.userName = user.userName
            self.user!.email = user.email
            self.user!.sex = user.sex
            self.user!.telPhone = user.telPhone
            self.user!.school = user.school
            self.user!.entranceYear = user.entranceYear
            self.user!.age = user.age
            self.user!.major = user.major
            self.user!.height = user.height
            self.user!.figure = user.figure
        }
        
        return status

    }
    
    /**
    更改用户性别
    
    :param: userName 用户名
    :param: sex      新的性别
    
    :returns: 返回一个状态码
    */
    func changeUserSex(userName:String!,sex:Int!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["sex"] = "\(sex)"
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_basic"
        
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.sex = sex
        }
        
        return status
    }
    
    /**
    更改用户电话号码
    
    :param: userName 用户名
    :param: telPhone 新电话号码
    
    :returns:返回一个状态码
    */
    func changeUserTelPhone(userName:String!,telPhone:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["tel_phone"] = telPhone
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_basic"
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.telPhone = telPhone
        }
        
        return status
    }
    
    /**
    更改用户邮箱
    
    :param: userName 用户名
    :param: email    新的邮箱
    
    :returns: 返回一个状态码
    */
    func changeUserEmail(userName:String!,email:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["email"] = email
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_basic"
        
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.email = email
        }
        
        return status
    }
    /**
    更改用户学校
    
    :param: userName 用户名
    :param: school   学校
    
    :returns: 返回一个状态码
    */
    func changeUserSchool(userName:String!,school:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["school"] = school
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_basic"
        
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.school   = school
        }
        
        return status
    }
    
    /**
    更改用户入学日期
    
    :param: userName     用户名
    :param: entranceYear 入学日期
    
    :returns: 返回一个状态码
    */
    func changeUserEntranceYear(userName:String!,entranceYear:Int!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["entrance_year"] = "\(entranceYear)"
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_basic"
        
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.entranceYear = entranceYear
        }
        
        return status
    }
    
    /**
    更改用户的专业
    
    :param: userName 用户名
    :param: major    新专业
    
    :returns: 返回一个状态码
    */
    func changeUserMajor(userName:String!,major:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["major"] = major
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_basic"
        
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.major = major
        }
        
        return status
    }
    
    /**
    更改用户年龄
    
    :param: userName 用户名
    :param: age      年龄
    
    :returns: 返回一个状态码
    */
    func changeUserage(userName:String!,age:Int!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["age"] = "\(age)"
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_basic"
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.age = age
        }
        
        return status
    }
    
    
    /**
    更改用户身高
    
    :param: userName 用户名
    :param: height   身高
    
    :returns: 返回一个状态码
    */
    func changeUserHeight(userName:String!,height:Int!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["height"] = "\(height)"
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_basic"
        
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.height = height
        }
        
        return status
    }
    
    /**
    更改用户体格
    
    :param: userName 用户名
    :param: figure   体格
    
    :returns: 返回一个状态码
    */
    func changeUserFigure(userName:String!,figure:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["figure"] = figure
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_basic"
        
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.figure = figure
        }
        
        return status
    }
    
    
    
    //修改用户应聘信息接口
    
    /**
    更改用户的应聘信息
    
    :param: user 用户数据
    
    :returns: 返回一个状态码
    */
    func changeUserAllEmploydata(user:User!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = user.userName
        dic["qq"] = user.qq
        dic["real_name"] = user.realName
        dic["mobile_phone"] = user.mobilePhone
        dic["agent_phone"] = user.agentPhone
        dic["job_want"] = user.jobWant
        dic["cer_id"] = user.cerId
        dic["work_info"] = user.workInfo
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_resume"
        
        var status =  changeUserData(dic)
        if status == 0
        {
            self.user!.userName = user.userName
            self.user!.qq = user.qq
            self.user!.realName = user.realName
            self.user!.mobilePhone = user.mobilePhone
            self.user!.agentPhone = user.agentPhone
            self.user!.jobWant =  user.jobWant
            self.user!.cerId = user.cerId
            self.user!.workInfo = user.workInfo
        }
        
        return status
    }
    
    
    /**
    更改用户QQ
    
    :param: userName 用户名
    :param: QQ       用户QQ
    
    :returns: 返回一个状态码
    */
    func changeUserQQ(userName:String!,QQ:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["qq"] = QQ
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_resume"
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.qq = QQ
        }
        
        return status

    }
    
    
    /**
    更改用户真实姓名
    
    :param: userName 用户名
    :param: realName 真实姓名
    
    :returns: 返回一个状态码
    */
    func changeUserRealName(userName:String!,realName:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["real_name"] = realName
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_resume"
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.realName = realName
        }
        
        return status
    }
    
    /**
    更改用户手机号码
    
    :param: userName    用户名
    :param: mobilePhone 手机号码
    
    :returns: 返回一个状态码
    */
    func changetUserMobilePhone(userName:String!,mobilePhone:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["mobile_phone"] = mobilePhone
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_resume"
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.mobilePhone = mobilePhone
        }
        
        return status
    }
    
    
    /**
    更改用户应急号码
    
    :param: userName   用户名
    :param: agentPhone 应急号码
    
    :returns: 返回一个状态码
    */
    func changeUserAgentPhone(userName:String!,agentPhone:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["agent_phone"] = agentPhone
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_resume"
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.agentPhone = agentPhone
        }
        
        return status
    }
    
    /**
    更改用户工作意向
    
    :param: userName 用户名
    :param: jobWant  工作意向
    
    :returns: 返回一个状态码
    */
    func changeUsrJobWant(userName:String!,jobWant:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["job_want"] = jobWant
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_resume"
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.jobWant = jobWant
        }
        
        return status
    }
    
    
    /**
    更改用户身份证号码
    
    :param: userName 用户名
    :param: cerId    身份证号码
    
    :returns: 返回一个状态码
    */
    func changeUserCerId(userName:String!,cerId:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["cer_id"] = cerId
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_resume"
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.cerId = cerId
        }
        
        return status
    }
    
    /**
    更改用户工作简历
    
    :param: userName 用户名
    :param: workInfo 工作简历
    
    :returns: 返回一个状态码
    */
    func changeUserWorkInfo(userName:String!,workInfo:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["work_info"] = workInfo
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_resume"
        
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.workInfo = workInfo
        }
        
        return status
    }
    
    
    //修改用户企业信息接口
    
    /**
    更改用户的企业信息
    
    :param: user 用户数据
    
    :returns: 返回一个状态码
    */
    func changeUserAllEnterpriseData(user:User!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = user.userName
        dic["licence"] = user.licence
        dic["com_info"] = user.comInfo
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_recruit"
        var status =  changeUserData(dic)
        if status == 0
        {
            self.user!.userName = user.userName
            self.user!.workInfo =  user.workInfo
            self.user!.licence =  user.licence
        }
        
        return status
    }
    
    
    /**
    更改用户营业执照号
    
    :param: userName 用户名
    :param: licence  营业执照
    
    :returns: 返回一个状态码
    */
    func changeLicence(userName:String!,licence:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["licence"] = licence
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_recruit"
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.licence = licence
        }
        
        return status
    }
    
    /**
    更改用户企业简介
    
    :param: userName 用户名
    :param: comInfo  企业简介
    
    :returns: 返回一个状态码
    */
    func changeComInfo(userName:String!,comInfo:String!)->Int
    {
        var dic = Dictionary<String,String>()
        dic["user_name"] = userName
        dic["com_info"] = comInfo
        dic["sys"] = "user"
        dic["ctrl"] = "user"
        dic["action"] = "mod_recruit"
        var status =  changeUserData(dic)
        if status == 0
        {
            user!.userName = userName
            user!.comInfo = comInfo
        }
        
        return status
    }

    
    
    
    /**
    从后台获取数据 ,采用异步请求，获得数据后会发送一个 UPDateUSERDATA 通知，传过去一个用户数据模型
    
    :param: userName 用户名
    :param: userId   用户id
    */
    func getUserDataFromNetwork(userName:String!,userId:Int!)
    {
        
        var url = NSURL(string: "http://shenghuodao.gotoip2.com/work/main.php");
        var request =  ASIFormDataRequest(URL:url)
        request.setPostValue(userName, forKey: "user_name")
        request.setPostValue(userId, forKey: "user_id")
        request.setPostValue("user", forKey: "sys")
        request.setPostValue("user", forKey: "ctrl")
        request.setPostValue("user_info", forKey: "action")
        
        request.setCompletionBlock { () -> Void in
            let responData = request.responseData()
            let  data: AnyObject? = NSJSONSerialization.JSONObjectWithData(responData, options:.MutableLeaves, error:nil)
            
            if data == nil
            {
                print("获取信息失败，请重新获取")
                return
            }
            let stauts = (data!.objectForKey("status") as! NSString).integerValue
            
            if stauts == 0
            {
                self.user!.id = (data!.objectForKey("user_id") as!NSString).integerValue
                self.user!.sex = (data!.objectForKey("sex") as? NSString)!.integerValue
                self.user!.email = (data!.objectForKey("email") as?String)
                self.user!.telPhone = data!.objectForKey("tel_phone") as?String
                self.user!.school = data!.objectForKey("school") as?String
                self.user!.entranceYear = (data!.objectForKey("entrance_year") as!NSString).integerValue
                self.user!.major = data!.objectForKey("major") as?String
                self.user!.age = (data!.objectForKey("age") as!NSString).integerValue
                self.user!.height = (data!.objectForKey("height") as!NSString).integerValue
                self.user!.figure = data!.objectForKey("figure") as?String
                self.user!.qq = data!.objectForKey("qq") as?String
                self.user!.realName = data!.objectForKey("real_name") as?String
                self.user!.mobilePhone = data!.objectForKey("mobile_phone")as?String
                self.user!.agentPhone = data!.objectForKey("agent_phone")as?String
                self.user!.jobWant = data!.objectForKey("job_want") as?String
                self.user!.cerId = data!.objectForKey("cer_id") as?String
                self.user!.workInfo = data!.objectForKey("work_info") as?String
                self.user!.comInfo = data!.objectForKey("com_info") as?String
                self.user!.licence = data!.objectForKey("licence") as?String
                self.user!.userName = userName
                
                
                self.SaveUsrDataCache(self.user!)
                NSNotificationCenter.defaultCenter().postNotificationName(UPDateUSERDATA, object: self.user!)
            }
            
        }
        request.delegate = self
        request.startAsynchronous()
    }
    
    /**
    将用户信息保存到本地
    
    :param: user 用户信息
    */
    func SaveUsrDataCache(user:User!)
    {
        var ud = NSUserDefaults.standardUserDefaults()
        var archdata = NSKeyedArchiver.archivedDataWithRootObject(user)
        
        var key = "userData_\(user.userName!)"
        ud.setObject(archdata, forKey:key)
        
    }
    
    /**
    从本地获取用户信息
    
    :param: username 用户名
    
    :returns:
    */
    func GetUserDataFromCache(username:String!)->Bool
    {
        var ud = NSUserDefaults.standardUserDefaults()
        
        var key = "userData_\(username)"
        
        var unarchdata:NSData? = ud.objectForKey(key) as? NSData
        if unarchdata != nil
        {
            var user =  NSKeyedUnarchiver.unarchiveObjectWithData(unarchdata!) as? User
            self.user = user
            return true
        }
        
        
        return false
    }
    
    
    
    /**
    更改用户信息
    
    :param: postDic 请求数据
    
    :returns: 返回一个状态码
    */
    func changeUserData(postDic:Dictionary<String,String>)->Int
    {
        return sendMessageModel(postDic)
    }
    
    
    /**
    发送请求包装
    
    :param: postData 请求的参数
    
    :returns: 返回请求的状态码
    */
    func sendMessageModel(postData:Dictionary<String,String>)->Int
    {
        var status = -1;
        var url = NSURL(string: "http://shenghuodao.gotoip2.com/work/main.php");
        var request =  ASIFormDataRequest(URL:url)
        
        for (key,value) in postData
        {
            request.setPostValue(value, forKey: key)
        }
        
        request.setCompletionBlock { () -> Void in
            let responseData = request.responseData()
            let  data: AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData, options:.MutableLeaves, error:nil)
            
            if data == nil
            {
                print("操作失败，请重新操作")
                return
            }
             status = (data!.objectForKey("status") as! NSString).integerValue
        }
        request.delegate = self
        request.startSynchronous()
        return status
    }
}
