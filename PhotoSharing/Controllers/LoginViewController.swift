//
//  LoginViewController.swift
//  PhotoSharing
//
//  Created by Никита Гундорин on 29.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit
import FacebookLogin
import VKSdkFramework
import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    let vkLoginButton = UIButton(type: .system)
    let fbLoginButton = FBLoginButton(permissions: [ .publicProfile ])
    let googleLoginButton = UIButton(type: .system)
    
    private var vkService: VKService!
    private var googleService: GoogleService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkService = AppDelegate.shared().vkService
        vkService.delegate = self
        
        googleService = AppDelegate.shared().googleService
        googleService.setUpLogin(viewController: self)

        updateVKButton()
        self.vkLoginButton.addTarget(self, action: #selector(self.vkLoginButtonPressed(sender:)), for: .touchUpInside)
        
        updateGoogleButton()
        self.googleLoginButton.addTarget(self, action: #selector(self.googleLoginButtonPressed(sender:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(fbLoginButton)
        stackView.addArrangedSubview(vkLoginButton)
        stackView.addArrangedSubview(googleLoginButton)
    }
    
    @objc func vkLoginButtonPressed(sender: UIButton) {
        if (vkService.token != nil) {
            showLogoutAlert(name: "VK") { action in
                self.vkService.logout()
                self.updateVKButton()
            }
        }
        else {
            vkService.wakeUpSession(withLogin: true)
        }
    }
    
    func updateVKButton() {
        if (vkService.token != nil) {
            self.vkLoginButton.setTitle("Logout from VK", for: .normal)
        }
        else {
            self.vkLoginButton.setTitle("Continue with VK", for: .normal)
        }
    }
    
    @objc func googleLoginButtonPressed(sender: UIButton) {
        if (GIDSignIn.sharedInstance()?.currentUser != nil) {
            showLogoutAlert(name: "Google") { action in
                self.googleService.signOut()
                self.updateGoogleButton()
            }
        }
        else {
            googleService.signIn()
            updateGoogleButton()
        }
    }
    
    func updateGoogleButton() {
        if (GIDSignIn.sharedInstance()?.currentUser != nil) {
            self.googleLoginButton.setTitle("Logout from Google", for: .normal)
        }
        else {
            self.googleLoginButton.setTitle("Continue with Google", for: .normal)
        }
    }
    
    func showLogoutAlert(name: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: nil, message: "Logout from \(name)?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: handler))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}

extension LoginViewController: VKServiceDelegate {
    func authVKServiceShouldShow(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func authVKServiceSignIn() {
        updateVKButton()
    }
    
    func authVKServiceDidSignInFail() {
        let alert = UIAlertController(title: "Error", message: "Sign in to VK failed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
