//
//  AppDelegate.swift
//  Lesson19Homework_Filters
//
//  Created by Petr Blinov on 17.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let service = FilterService()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController(filterService: service))
        //        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()

        return true
    }

}

