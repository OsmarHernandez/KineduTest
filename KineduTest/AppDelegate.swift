//
//  AppDelegate.swift
//  KineduTest
//
//  Created by Osmar Hernández on 13/02/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let navigationController = window?.rootViewController as? UINavigationController {
            let homeViewController = navigationController.viewControllers.first as! HomeViewController
            
            KineduAPI.requestNetPromoterScores(completion: homeViewController.handleNetPromoterScoresRequest(_:error:))
            
            sleep(1)
            
            return true
        }
        
        return false
    }
}

