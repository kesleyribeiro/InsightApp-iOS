//
//  AppDelegate.swift
//  InsightApp
//
//  Created by Kesley Ribeiro on 15/May/17.
//  Copyright © 2017 Kesley Ribeiro. All rights reserved.
//

import UIKit
import Firebase

// Variáveis global
let KEY_UID = "uid"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            let insightVC = InsightVC()
            window.rootViewController = UINavigationController(rootViewController: insightVC)
            window.makeKeyAndVisible()
        }

        // Define as cores da NavigationBar e dos ícones que estiver nela
        UINavigationBar.appearance().barTintColor = UIColor(red: 36/255, green: 34/255, blue: 74/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor(red: 41/255, green: 121/255, blue: 255/255, alpha: 1)
        
        // Define o tipo de font e o seu tamanho
        if let navBarFont = UIFont(name: "Avenir-Light", size: 24) {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.yellow, NSFontAttributeName:navBarFont]
        }

        // Muda a aparência da status bar para branco
        UIApplication.shared.statusBarStyle = .lightContent        

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

