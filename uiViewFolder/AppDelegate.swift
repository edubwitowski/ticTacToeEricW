//
//  AppDelegate.swift
//  ticTacToeEricW
//
//  Created by Macbook on 1/30/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barStyle = .blackOpaque
        
        return true
    }
    
    
}
