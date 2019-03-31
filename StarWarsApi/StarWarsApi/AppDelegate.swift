//
//  AppDelegate.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 30/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //TODO: Improve this code
        let tabBarViewController = UITabBarController(nibName: nil, bundle: nil)
        let charsVC = ViewController()
        charsVC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(named: "star-wars"), selectedImage: nil)
        let aboutVC = AboutViewController()
        aboutVC.tabBarItem = UITabBarItem(title: "About Meh", image: UIImage(named: "leia"), selectedImage: nil)
        tabBarViewController.tabBar.tintColor = SWColorScheme.gold
        tabBarViewController.tabBar.barTintColor = SWColorScheme.black
        tabBarViewController.setViewControllers([charsVC, aboutVC], animated: false)
        
        let initialViewController = UINavigationController(rootViewController: tabBarViewController)
        initialViewController.delegate = charsVC
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        
        window!.rootViewController = initialViewController
        window!.makeKeyAndVisible()
        
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

