//
//  AppDelegate.swift
//  LifeIsland
//
//  Created by 张世杰 on 15/4/30.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var RootTaB:BaseViewController?

   
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds]
        self.window = UIWindow(frame:UIScreen.mainScreen().bounds)
        self.window!.makeKeyAndVisible()
        
    NSUserDefaults.standardUserDefaults().removeObjectForKey("numToLogIn")
//
//        RootTaB = UITabBarController()
//        var CalendarVC = CalendarViewController();
//        var ChatVC = ChatViewController();
//        var OtherVC = OtherViewController(nibName:"OtherViewController",bundle:nil);
//        
//        var OtherNav = UINavigationController(rootViewController: OtherVC)
//        var CalendarNav = UINavigationController(rootViewController: CalendarVC)
//        var ChatNav = UINavigationController(rootViewController: ChatVC)
//        RootTaB!.setViewControllers([OtherNav,ChatNav,CalendarNav], animated: true);
//
//        self.window?.rootViewController = RootTaB
//      
        
        
        var ud = NSUserDefaults.standardUserDefaults()
        var num:String? = ud.objectForKey("numToLogIn") as? String
        
        if num == nil
        {
            var guideVC = GuideViewController(nibName:"GuideViewController",bundle:nil)
            
            self.window!.rootViewController = guideVC
            
        }else{
        
        if hasUserLogIning() == false {
        
        var logVC = LogInViewController(nibName:"LogInViewController",bundle:nil)
        var nav = UINavigationController(rootViewController:logVC)
        self.window?.rootViewController = nav
        }else
        {
            var  RootTaB = BaseViewController()
            var CalendarVC = CalendarViewController();
            var ChatVC = ChatViewController();
            var OtherVC = OtherViewController(nibName:"OtherViewController",bundle:nil);
            
            var OtherNav = UINavigationController(rootViewController: OtherVC)
            var CalendarNav = UINavigationController(rootViewController: CalendarVC)
            var ChatNav = UINavigationController(rootViewController: ChatVC)
            
            RootTaB.setViewControllers([OtherNav,ChatNav,CalendarNav], animated: true);
            RootTaB.tabBar.hidden = true
            RootTaB.selectedIndex = 0
            self.window?.rootViewController = RootTaB
            
        }
        }
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 109/255, green: 137/255, blue: 190/255, alpha:1)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        
        ud.setObject("1", forKey: "numToLogIn")
        return true
    }
    
    
    
    
    /**
    是否用户已经登录
    
    :returns: 如果已经登录返回true
    */
    func hasUserLogIning()->Bool
    {
        var hasLog = false
        var userMg = UserManager.getInstance

        userMg.GetUserNameFormCache()
        if userMg.user!.userName != nil {

            userMg.GetUserDataFromCache(userMg.user!.userName)

            if userMg.user!.id  == nil
            {
                hasLog = false
            }else{
                hasLog = true
            }
        }else
        {
            hasLog = false
        }
        return hasLog
    }

//    /**
//    跳转到登录界面
//    */
//    func PresentToLogInView()
//    {
//        var log = LogInViewController(nibName:"LogInViewController",bundle:nil)
//        log.view.frame = UIScreen.mainScreen().bounds
//        var nav = UINavigationController(rootViewController: log)
//        nav.navigationBar.tintColor = UIColor.whiteColor()
//        self.presentViewController(nav, animated: true, completion: nil)
//    }

    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "willToSky.com.LifeIsland" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("LifeIsland", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("LifeIsland.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}

