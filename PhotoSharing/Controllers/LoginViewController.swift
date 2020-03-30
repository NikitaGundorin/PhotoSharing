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

class LoginViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    let vkLoginButton = UIButton(type: .system)
    let fbLoginButton = FBLoginButton(permissions: [ .publicProfile ])
    private var vkService: VKService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkService = AppDelegate.shared().vkService
        vkService.delegate = self

        updateVKButton()
        self.vkLoginButton.addTarget(self, action: #selector(self.vkLoginButtonPressed(sender:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(fbLoginButton)
        stackView.addArrangedSubview(vkLoginButton)
    }
    
    @objc func vkLoginButtonPressed(sender: UIButton) {
        if (vkService.token != nil) {
            let alert = UIAlertController(title: nil, message: "Logout from VK?", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { action in
                self.vkService.logout()
                self.updateVKButton()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            self.present(alert, animated: true)
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
