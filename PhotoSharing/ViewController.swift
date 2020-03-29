//
//  ViewController.swift
//  PhotoSharing
//
//  Created by Никита Гундорин on 29.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit
import FacebookLogin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton(permissions: [ .publicProfile ])
        loginButton.center = view.center

        view.addSubview(loginButton)
    }


}

