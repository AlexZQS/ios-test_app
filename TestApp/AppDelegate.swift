//// 
//  AppDelegate.swift
//  
//  Created by ___ORGANIZATIONNAME___ on 2024/5/31
//  
//
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
//    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
    
    var delegateManager =  DelegateManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
//        flutterEngine.run()
//        GeneratedPluginRegistrant.register(with: self.flutterEngine)
        // Override point for customization after application launch.
        
//        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        // 一、通过StoryBoard方式创建控制器
        //var storyboard = UIStoryboard.init(name: "Me", bundle: nil)
        // 1、初始化StoryBoard中箭头指向的控制器
        //self.window?.rootViewController = storyboard.instantiateInitialViewController()
        // 2、初始化StoryBoard中id为aaa的控制器
        //self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "aaa")
        
        // 二、XIB方式创建控制器
        //let vc = XibViewController()
        
        // 从XIB转为UIView
        //var xibView = Bundle.main.loadNibNamed("Common", owner: vc)?.first
        // vc.view = XIB转换过来的View
        //if let mXibView = xibView as? UIView{
        //    vc.view = mXibView
        //}
        
        //vc.view.backgroundColor = UIColor.red
        //self.window?.rootViewController = vc
        
        // 三、模态跳转
//        var stroyBoard = UIStoryboard.init(name: "Modal", bundle: nil)
//        self.window?.rootViewController = stroyBoard.instantiateInitialViewController()
//        
//        
        
        
        // 四、导航栏跳转
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let rootViewController = MainViewController()
        let navigationController = CustomNavigationViewController.init(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        
        
        self.window?.makeKeyAndVisible()
        
//        rootViewController.navigationController = navigationController
        
        return true
    }
    
    

    // MARK: UISceneSession Lifecycle


   


}

