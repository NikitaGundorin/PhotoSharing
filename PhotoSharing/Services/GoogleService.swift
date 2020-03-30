//
//  GoogleService.swift
//  PhotoSharing
//
//  Created by Никита Гундорин on 30.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import Foundation
import GoogleSignIn

class GoogleService: NSObject, GIDSignInDelegate {
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().clientID = "370904808514-gae7vi6a69edavpqhmbvata5qtu6v7up.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    func setUpLogin(viewController: UIViewController) {
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
    }
    
    func signIn() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signOut() {
        GIDSignIn.sharedInstance().signOut()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
        let vc = GIDSignIn.sharedInstance()?.presentingViewController as? LoginViewController
        vc?.updateGoogleButton()
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
    
}
