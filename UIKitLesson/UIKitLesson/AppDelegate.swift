//
//  AppDelegate.swift
//  UIKitLesson
//
//  Created by Петр Блинов on 19.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Если создаем Navigation controller
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        
        // А это раскомментить если надо без Navigation Controller
        // window?.rootViewController = ViewController()
        
        window?.makeKeyAndVisible()

        return true
    }
}

