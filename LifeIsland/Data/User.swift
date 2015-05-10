//
//  User.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/7.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

class User: NSObject,NSCoding{
    //基本信息
    var id:Int?
    var sex:Int?
    var entranceYear:Int?
    var age:Int?
    var height:Int?
    var userName:String?
    var email:String?
    var telPhone:String?
    var school:String?
    var major:String?
    var figure:String?
    
    //应聘信息
    
    var qq:String?
    var realName:String?
    var mobilePhone:String?
    var agentPhone:String?
    var jobWant:String?
    var cerId:String?
    var workInfo:String?
    
    //企业信息
    
    var licence:String?
    var comInfo:String?
    
    override init() {
        
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(userName, forKey: "userName")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(sex, forKey: "sex")
        aCoder.encodeObject(telPhone, forKey: "telPhone")
        aCoder.encodeObject(school, forKey: "school")
        aCoder.encodeObject(entranceYear, forKey: "entranceYear")
        aCoder.encodeObject(major, forKey: "major")
        aCoder.encodeObject(age, forKey: "age")
        aCoder.encodeObject(height, forKey: "height")
        aCoder.encodeObject(figure, forKey: "figure")
        aCoder.encodeObject(qq, forKey: "qq")
        aCoder.encodeObject(realName, forKey: "realName")
        aCoder.encodeObject(mobilePhone, forKey: "mobilePhone")
        aCoder.encodeObject(agentPhone, forKey: "agentPhone")
        aCoder.encodeObject(jobWant, forKey: "jobWant")
        aCoder.encodeObject(workInfo, forKey: "workInfo")
        aCoder.encodeObject(cerId, forKey: "cerId")
        aCoder.encodeObject(licence, forKey: "licence")
        aCoder.encodeObject(comInfo, forKey: "comInfo")
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init()
        
        self.id = aDecoder.decodeObjectForKey("id") as? Int
        self.sex = aDecoder.decodeObjectForKey("sex") as? Int
        self.entranceYear = aDecoder.decodeObjectForKey("entranceYear") as? Int
        self.age = aDecoder.decodeObjectForKey("age") as? Int
        self.height = aDecoder.decodeObjectForKey("height") as? Int
        
        self.userName = aDecoder.decodeObjectForKey("userName") as? String
        self.email = aDecoder.decodeObjectForKey("email") as? String
        self.telPhone = aDecoder.decodeObjectForKey("telPhone") as? String
        self.school = aDecoder.decodeObjectForKey("school") as? String
        self.major = aDecoder.decodeObjectForKey("major") as? String
        self.figure = aDecoder.decodeObjectForKey("figure") as? String
        self.qq = aDecoder.decodeObjectForKey("qq") as? String
        self.realName = aDecoder.decodeObjectForKey("realName") as? String
        self.mobilePhone = aDecoder.decodeObjectForKey("mobilePhone") as? String
        self.agentPhone = aDecoder.decodeObjectForKey("agentPhone") as? String
        self.jobWant = aDecoder.decodeObjectForKey("jobWant") as? String
        self.cerId = aDecoder.decodeObjectForKey("cerId") as? String
        self.workInfo = aDecoder.decodeObjectForKey("workInfo") as? String
        self.licence = aDecoder.decodeObjectForKey("licence") as? String
        self.comInfo = aDecoder.decodeObjectForKey("comInfo") as? String

        
        
    }
}
