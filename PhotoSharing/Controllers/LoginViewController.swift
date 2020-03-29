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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fbLoginButton = FBLoginButton(permissions: [ .publicProfile ])
        fbLoginButton.center = view.center

        self.vkLoginButton.setTitle("Continue with VK", for: .normal)
        self.vkLoginButton.addTarget(self, action: #selector(self.vkLoginButtonPressed(sender:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(fbLoginButton)
        stackView.addArrangedSubview(vkLoginButton)
    }
    
    @objc func vkLoginButtonPressed(sender: UIButton) {
        VKSdk.authorize(["email"])
    }
}
