//
//  DataManager.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/5/7.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit


var _dataManager:DataManager!
class DataManager: NSObject {
   
    /**
    单例模式，获得数据管理类
    
    :returns: 数据管理器
    */
    class func getInstane()->DataManager
    {
        if let hasDataManager = _dataManager
        {
            _dataManager = DataManager()
        }
        return _dataManager;
    }
    
//    func getPartTimeJobData()->
    
}
