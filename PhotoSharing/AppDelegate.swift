//
//  AppDelegate.swift
//  PhotoSharing
//
//  Created by Никита Гундорин on 29.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit
import FacebookCore
import VKSdkFramework
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, VKServiceDelegate {
    var window: UIWindow?
    var vkService: VKService!
    var googleService: GoogleService!
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        self.vkService = VKService()
        self.googleService = GoogleService()
        
        window = UIWindow()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateInitialViewController()
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, options: options)
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        GIDSignIn.sharedInstance().handle(url)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        VKSdk.processOpen(url, fromApplication: sourceApplication)
        return true
    }
    
    func authVKServiceShouldShow(_ viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authVKServiceSignIn() {
        print(#function)
    }
    
    func authVKServiceDidSignInFail() {
        print(#function)
    }
}
