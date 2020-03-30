//
//  SharingViewController.swift
//  PhotoSharing
//
//  Created by Никита Гундорин on 29.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit
import FacebookShare
import VKSdkFramework

class SharingViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    var image: UIImage? {
        didSet {
            guard let image = image else {
                return
            }
            let content = SharePhotoContent()
            content.photos = [SharePhoto(image: image, userGenerated: true)]
            fbShareButton.shareContent = content
        }
    }
    
    let fbShareButton = FBShareButton()
    let vkShareButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVkShareButton()

        stackView.addArrangedSubview(fbShareButton)
        stackView.addArrangedSubview(vkShareButton)
    }
    
    func setUpVkShareButton() {
        let vkService = AppDelegate.shared().vkService
        if (vkService?.token == nil) {
            vkShareButton.isEnabled = false
        }
        vkShareButton.setTitle("Share in VK", for: .normal)
        vkShareButton.addTarget(self, action: #selector(self.vkShareButtonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func vkShareButtonPressed(sender: UIButton) {
        guard let image = image else {
            vkShareButton.isEnabled = false
            return
        }
        var vkShareDialog = VKShareDialogController()
        vkShareDialog.uploadImages = [image]
        vkShareDialog.dismissAutomatically = true
        self.present(vkShareDialog, animated: true)
    }
}
