//
//  AppDelegate.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/2/21.
//

import UIKit
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //styling
        Style.setupTheme(theme: .default_)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LauncherViewController()
        window?.makeKeyAndVisible()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.window?.rootViewController = HomeViewController()
        }
        return true
    }


}

