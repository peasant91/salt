//
//  AppDelegate.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 07/11/22.
//

import UIKit
import IQKeyboardManagerSwift
import AlamofireNetworkActivityLogger
import AlamofireNetworkActivityIndicator

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        
        IQKeyboardManager.shared.enable = true
        
        return true
    }

}

