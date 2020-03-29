//
//  MainViewController.swift
//  PhotoSharing
//
//  Created by Никита Гундорин on 29.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit

import FacebookShare
import Social

class MainViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var image: UIImage? {
        didSet {
            guard let image = image else {
                return
            }
            imageView.image = image
            let content = SharePhotoContent()
            content.photos = [SharePhoto(image: image, userGenerated: true)]
            self.shareButton.shareContent = content
        }
    }
    
    let shareButton = FBShareButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.center = CGPoint(x: 171, y: 600)

        view.addSubview(shareButton)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
}

