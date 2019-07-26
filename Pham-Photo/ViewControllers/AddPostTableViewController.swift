//
//  AddPostTableViewController.swift
//  Pham-Photo
//
//  Created by Colin Smith on 7/21/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    @IBOutlet weak var captionTextField: UITextField!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
        self.tabBarController?.selectedIndex = 0
        
    }
    
    

    
    @IBAction func addPostButtonPressed(_ sender: UIButton) {
        
        if let text = captionTextField.text,
           let picture = selectedImage,
            text != "" {
            print("Made it inside the Unwrapping Box")
            PostController.shared.createPostWith(image: picture, caption: text) { (post) in
                //Come back to this later
            }
        }
        captionTextField.text = ""
        
        self.tabBarController?.selectedIndex = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectorVC" {
            let photoSelector = segue.destination as? PhotoSelectorViewController
            photoSelector?.delegate = self
        }
    }
}// End of View Controller Class

extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
        selectedImage = image
    }
}
