//
//  SharingViewController.swift
//  PhotoSharing
//
//  Created by Никита Гундорин on 29.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit
import FacebookShare

class SharingViewController: UIViewController {
    var image: UIImage? {
        didSet {
            guard let image = image else {
                return
            }
            let content = SharePhotoContent()
            content.photos = [SharePhoto(image: image, userGenerated: true)]
            shareButton.shareContent = content
        }
    }
    
    let shareButton = FBShareButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        shareButton.center = view.center

        view.addSubview(shareButton)
    }
}
