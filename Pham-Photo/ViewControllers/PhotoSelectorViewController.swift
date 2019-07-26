//
//  PhotoSelectorViewController.swift
//  Pham-Photo
//
//  Created by Colin Smith on 7/23/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

protocol PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage)
}


class PhotoSelectorViewController: UIViewController {
    
    @IBOutlet weak var postPicture: UIImageView!
    
    var delegate: PhotoSelectorViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        postPicture.image = UIImage(named: "default")
    }
    @IBAction func selectPhotoButtonPressed(_ sender: UIButton) {
         presentImagePickerActionSheet()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.postPicture.image = photo
            delegate?.photoSelectorViewControllerSelected(image: photo)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func presentImagePickerActionSheet(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Upload Image", message: "Select a photo", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePickerController, animated:  true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true , completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
}
