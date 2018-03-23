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
    
    //인디케이터 객체
    var actIdc = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var container: UIView!
    
    //AppDelegate 객체
    class func instance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    //인디케이터 시작
    func showActivityIndicator(){
        if let window = window{
            print("showActivityIndicator 인디케이터 호출")
            container = UIView()
            container.frame = window.frame
            container.center = window.center
            container.backgroundColor = UIColor(white:0, alpha:0.2)
            //actIdc.color = UIColor.black
            actIdc.frame = CGRect(x: 0 , y: 0, width:40, height:40)
            actIdc.hidesWhenStopped = true
            actIdc.center = CGPoint(x: container.frame.size.width / 2, y: container.frame.size.height / 2)
            container.addSubview(actIdc)
            window.addSubview(container)
            
            actIdc.startAnimating()
        }
    }
    
    //인디케이터 삭제
    func dissmissActivityIndicator(){
        if let _ = window{
            print("dissmiss 인디케이터 호출")
            container.removeFromSuperview()
        }
    }
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
    
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        //앱이 켜지면 바로 메인뷰로 진입
        let MainView = MainViewController()
        self.window?.rootViewController = MainView
        
        //로그인 성공 후 기본 레이아웃은 탭바 컨트롤러
        tabBarController = UITabBarController()
        tabBarController?.view.backgroundColor = UIColor.white
        tabBarController?.view.tintColor = UIColor.white
        tabBarController?.tabBar.barTintColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)

        
        //collectionView layout - 반드시 넣어줘야 함
        //let layout = UICollectionViewFlowLayout()

        let talkVC = TalkViewController()
        
        //let memoryVC = MemoryViewController()
        //let notictVC = NoticeViewController(collectionViewLayout: layout)
        //let birthVC = BirthViewController()
        
        let noticeAH = NoticeAHVC()
        let jobAH = JobAHVC()
        let makating = MakatingAHVC()
        
        
        let settingVC = SettingViewController()
        

        
        let talkNavVC = UINavigationController(rootViewController: talkVC)
        let noticeNavVC = UINavigationController(rootViewController: noticeAH)
        let jobNavVC = UINavigationController(rootViewController: jobAH)
         let makatingNavVC = UINavigationController(rootViewController: makating)
        let settingNavVC = UINavigationController(rootViewController: settingVC)
        
        
        tabBarController?.setViewControllers([talkNavVC,noticeNavVC,jobNavVC,makatingNavVC,settingNavVC], animated: false)
        
    
    
        
        //탭바 이미지 넣기
        talkNavVC.tabBarItem.image = UIImage(named:"ic_chat")?.withRenderingMode(.alwaysTemplate)
        noticeNavVC.tabBarItem.image = UIImage(named:"ic_camera_roll")?.withRenderingMode(.alwaysTemplate)
        jobNavVC.tabBarItem.image = UIImage(named:"ic_event_note")?.withRenderingMode(.alwaysTemplate)
        makatingNavVC.tabBarItem.image = UIImage(named:"ic_add_alert")?.withRenderingMode(.alwaysTemplate)
        settingNavVC.tabBarItem.image = UIImage(named:"ic_view_headline")?.withRenderingMode(.alwaysTemplate)
        
        
        //이미지 선택되었을 때
        
       
        talkNavVC.tabBarItem.selectedImage = UIImage(named:"ic_chat_white")?.withRenderingMode(.alwaysOriginal)
        noticeNavVC.tabBarItem.selectedImage = UIImage(named:"ic_camera_roll_white")?.withRenderingMode(.alwaysOriginal)
        jobNavVC.tabBarItem.selectedImage = UIImage(named:"ic_event_note_white")?.withRenderingMode(.alwaysOriginal)
        makatingNavVC.tabBarItem.image = UIImage(named:"ic_add_alert")?.withRenderingMode(.alwaysTemplate)
        settingNavVC.tabBarItem.selectedImage = UIImage(named:"ic_view_headline_white")?.withRenderingMode(.alwaysOriginal)
       

        
        talkNavVC.tabBarItem.title = "동네토크"
        noticeNavVC.tabBarItem.title = "동네소식"
        jobNavVC.tabBarItem.title = "동네구인"
        makatingNavVC.tabBarItem.title = "동네홍보"
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

