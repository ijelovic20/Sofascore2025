//
//  AppDelegate.swift
//  Sofascore2025
//
//  Created by Ivona Jelovic on 05.03.2025..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: ViewController())
        navController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}
