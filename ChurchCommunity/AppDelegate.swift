//
//  AppDelegate.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 12..
//  Copyright © 2018년 MacBookPro. All rights reserved.

import UIKit
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController:UITabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
    
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        //앱이 켜지면 바로 메인뷰로 진입
        let MainView = MainViewController()
        self.window?.rootViewController = MainView
        
        //로그인 성공 후 기본 레이아웃은 탭바 컨트롤러
        tabBarController = UITabBarController()
        tabBarController?.view.backgroundColor = UIColor.yellow
        
        
        //collectionView layout - 반드시 넣어줘야 함
        let layout = UICollectionViewFlowLayout()

        let talkVC = TalkViewController()
        let memoryVC = MemoryViewController(collectionViewLayout: layout)
        let notictVC = NoticeViewController(collectionViewLayout: layout)
        let settingVC = SettingViewController()
        
        let talkNavVC = UINavigationController(rootViewController: talkVC)
        let memoryNavVC = UINavigationController(rootViewController: memoryVC)
        let notictNavVC = UINavigationController(rootViewController: notictVC)
        let settingNavVC = UINavigationController(rootViewController: settingVC)
        
        
        tabBarController?.setViewControllers([talkNavVC,memoryNavVC,notictNavVC,settingNavVC], animated: false)
        
        //탭바 이미지 넣기
        talkNavVC.tabBarItem.image = UIImage(named:"ic_chat")?.withRenderingMode(.alwaysOriginal)
        memoryNavVC.tabBarItem.image = UIImage(named:"ic_collections")?.withRenderingMode(.alwaysOriginal)
        notictNavVC.tabBarItem.image = UIImage(named:"ic_add_alert")?.withRenderingMode(.alwaysOriginal)
        settingNavVC.tabBarItem.image = UIImage(named:"ic_view_headline")?.withRenderingMode(.alwaysOriginal)
        
        
        //이미지 선택되었을 때
        let image = UIImage(named: "ic_done")?.withRenderingMode(.alwaysOriginal)
        talkNavVC.tabBarItem.selectedImage = image
        memoryNavVC.tabBarItem.selectedImage = image
        notictNavVC.tabBarItem.selectedImage = image
        settingNavVC.tabBarItem.selectedImage = image
        
        
        
        talkNavVC.tabBarItem.title = "수다방"
        memoryNavVC.tabBarItem.title = "추억방"
        notictNavVC.tabBarItem.title = "알림방"
        settingNavVC.tabBarItem.title = "더보기"
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

