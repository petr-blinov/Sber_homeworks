//
//  AppDelegate.swift
//  Lesson17HomeworkNewsApp
//
//  Created by Петр Блинов on 03.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let service = NetworkService()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController(networkService: service))
        window?.makeKeyAndVisible()
        return true
    }
}

