//
//  FinishUserProfileViewController.swift
//  Goji
//
//  Created by Michael Guatambu Davis on 10/21/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class FinishUserProfileViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Properties
    
    // activity indicator outlet
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // title
    @IBOutlet weak var finishProfileLabelOutlet: UILabel!
    // error messaging
    @IBOutlet weak var errorMessageViewOutlet: UIView!
    @IBOutlet weak var errorMessageLine1LabelOutlet: UILabel!
    @IBOutlet weak var errorMessageLine2LabelOutlet: UILabel!
    // profile pic credentials
    @IBOutlet weak var profilePicLabelOutlet: UILabel!
    // macro aggreagte profile pic view
    @IBOutlet weak var addProfilePicViewOutlet: UIView!
    // profile pic glyph imageView
    @IBOutlet weak var placeholderProfilePicImageViewOutlet: UIImageView!
    // invisible add profile pic button outlet (entire size of addProfilePicViewOutlet)
    @IBOutlet weak var chooseProfilePicButtonOutlet: UIButton!
    // choose profile pic 'button' image DesgnableView
    @IBOutlet weak var chooseProfilePicButtonImageOutlet: DesignableView!
    // actual selected image profile pic preview complex
    @IBOutlet weak var profilePicPreviewOutlet: DesignableView!
    @IBOutlet weak var profilePicPreviewImageViewOutlet: UIImageView!
    // email credentials outlets
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    // first name outlets
    @IBOutlet weak var firstNameLabelOutlet: UILabel!
    @IBOutlet weak var firstNameTextFieldOutlet: UITextField!
    // last name outlets
    @IBOutlet weak var lastNameLabelOutlet: UILabel!
    @IBOutlet weak var lastNameTextFieldOutlet: UITextField!
    // your location outlets
    @IBOutlet weak var yourLocationLabelOutlet: UILabel!
    @IBOutlet weak var yourLocationTextFieldOutlet: UITextField!
    // user bio outlets
    @IBOutlet weak var userBioLabelOutlet: UILabel!
    @IBOutlet weak var userBioTextViewOutlet: UITextView!
    // characters remaining count label outlet
    @IBOutlet weak var charactersRemainingLabelOutlet: UILabel!
    
    // relevant constraints
    @IBOutlet weak var userMessagesActionViewTopConstraint: NSLayoutConstraint!
    let originalTopMarginForUserMessageStackView: CGFloat = 16
    
    var userAccount: User?
    
    var isProfilePicSelected: Bool = false
    
    // **** need to add profile pic image viewer property
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        if isProfilePicSelected {
            placeholderProfilePicImageViewOutlet.isHidden = true
            profilePicPreviewOutlet.isHidden = false
            // set constraints to move chooseProfilePicButtonImageOutlet constraints to accommodate preview pic
        } else {
            placeholderProfilePicImageViewOutlet.isHidden = false
            profilePicPreviewOutlet.isHidden = true
            // set constraints to move chooseProfilePicButtonImageOutlet constraints to accommodate placeholderProfilePicImageViewOutlet
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITextView delegate
        userBioTextViewOutlet.delegate = self
        // dismiss keyboard when tap anywhere on screen
        self.hideKeyboardOnRandomScreenTap()
    }
    
    
    // MARK: - Actions
    
    @IBAction func xToCloseButtonTapped(_ sender: Any) {
        // pop viewController
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addProfilePicButtonTapped(_ sender: Any) {
        // allow user to snap or uplaod a profile pic
        presentImagePicker()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        
    }
    
    
    // MARK: - Helper Methods
    
    // move view up to accommodate keyboard presentaiton
    func moveViewUp() {
        
        if userMessagesActionViewTopConstraint.constant != originalTopMarginForUserMessageStackView {
            return
        }
        userMessagesActionViewTopConstraint.constant -= 135
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // move view down to accommodate keyboard presentaiton
    func moveViewDown() {
        if userMessagesActionViewTopConstraint.constant == originalTopMarginForUserMessageStackView {
            return
        }
        userMessagesActionViewTopConstraint.constant = originalTopMarginForUserMessageStackView
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
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


// MARK: - UITextFieldDelegate
extension FinishUserProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveViewUp()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveViewDown()
    }
}


// MARK: - UINavigationControllerDelegate
extension FinishUserProfileViewController: UINavigationControllerDelegate {
}


// MARK: - UIImagePickerControllerDelegate
extension FinishUserProfileViewController: UIImagePickerControllerDelegate {
    func presentImagePicker() {
        
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Image",
                                                       message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                                             style: .default) { (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker, animated: true)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        let libraryButton = UIAlertAction(title: "Choose Existing",
                                          style: .default) { (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker, animated: true)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        
        present(imagePickerActionSheet, animated: true)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedPhoto = info["UIImagePickerControllerOriginalImage"] as? UIImage,
            let scaledImage = selectedPhoto.scaleImage(640) {
            
            activityIndicator.startAnimating()
            
            dismiss(animated: true, completion: {
                self.placeholderProfilePicImageViewOutlet.image = scaledImage
                self.activityIndicator.stopAnimating()
            })
        }
    }
}


// MARK: - UIImage extension
extension UIImage {
    func scaleImage(_ maxDimension: CGFloat) -> UIImage? {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            let scaleFactor = size.width / size.height
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}

