//
//  AppDelegate.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 10/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        customizeAppearance()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private

    func customizeAppearance() {
        customizeStatusBar()
        customizeTabBar()
        customizeNavBar()
    }

    func customizeStatusBar() {
        let width = UIScreen.main.bounds.width

        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        statusBarView.backgroundColor = UIColor.primary

        window?.rootViewController?.view.addSubview(statusBarView)
    }

    func customizeTabBar() {
        UITabBar.appearance().tintColor = UIColor.primary
        UITabBar.appearance().barTintColor = UIColor.white
    }

    func customizeNavBar() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.primary

        let backButtonImage = UIImage(named: "Back")

        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage

        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
}

