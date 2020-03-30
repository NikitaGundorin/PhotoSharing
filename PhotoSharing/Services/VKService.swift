//
//  VKService.swift
//  PhotoSharing
//
//  Created by Никита Гундорин on 30.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol VKServiceDelegate: class {
    func authVKServiceShouldShow(_ viewController: UIViewController)
    func authVKServiceSignIn()
    func authVKServiceDidSignInFail()
}

final class VKService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7380964"
    let vkSdk: VKSdk
    
    weak var delegate: VKServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
        wakeUpSession(withLogin: false)
    }
    
    func wakeUpSession(withLogin: Bool) {
        let scope = ["offline"]
        
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                delegate?.authVKServiceSignIn()
            } else if (state == VKAuthorizationState.initialized && withLogin) {
                VKSdk.authorize(scope)
            } else {
                print("Auth problems, state \(state) error \(String(describing: error))")
                delegate?.authVKServiceDidSignInFail()
            }
        }
    }
    
    func logout() {
        VKSdk.forceLogout()
    }
    
    // MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authVKServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authVKServiceDidSignInFail()
        print("vkSdkUserAuthorizationFailed")
    }
    
    // MARK: VkSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authVKServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("vkSdkNeedCaptchaEnter")
    }
}

