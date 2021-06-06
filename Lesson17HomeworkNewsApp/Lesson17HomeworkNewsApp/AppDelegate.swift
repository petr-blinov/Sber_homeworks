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
        
        let navigationController = UINavigationController()
        let rootViewController = ViewController(networkService: service)
        navigationController.viewControllers = [rootViewController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}

