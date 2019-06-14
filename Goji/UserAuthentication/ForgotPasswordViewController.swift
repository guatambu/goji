//
//  ForgotPasswordViewController.swift
//  Goji
//
//  Created by Michael Guatambu Davis on 10/21/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var resetPasswordLabelOutlet: UILabel!
    @IBOutlet weak var resetUserMessageLabelOutlet: UILabel!
    @IBOutlet weak var errorMessageStackView: UIStackView!
    @IBOutlet weak var errorMessageLine1LabelOutlet: UILabel!
    @IBOutlet weak var errorMessageLine2LabelOutlet: UILabel!
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var sendEmailButtonOutlet: DesignableButton!
    
    // relevant constraints
    @IBOutlet weak var userMessageStackViewTopConstraint: NSLayoutConstraint!
    let originalTopMarginForUserMessageStackView: CGFloat = 16
    
    let authManager = AuthManager()
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        errorMessageStackView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dismiss keyboard when tap anywhere on screen
        self.hideKeyboardOnRandomScreenTap()
    }
    
    
    // MARK: - Actions
    
    @IBAction func xToCloseButtonTapped(_ sender: UIBarButtonItem) {
        // pop viewController
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendEmailButtonTapped(_ sender: Any) {
        
        guard let userEmailInput = emailTextFieldOutlet.text, emailTextFieldOutlet.text != "" else {
            errorMessageStackView.isHidden = false
            errorMessageLine1LabelOutlet.text = "Oops! No email, no password reset."
            errorMessageLine2LabelOutlet.text = "Please enter your email in the field below."
            return
        }
        
        // send user the email to reset their password
        authManager.sendPassworReset(toEmail: userEmailInput) { (success) in
            if success {
                // return user to where they were in the nav stack
                // pop viewController
                self.navigationController?.popViewController(animated: true)
                
            } else {
                self.errorMessageStackView.isHidden = false
                self.errorMessageLine1LabelOutlet.text = "Apologies. We may be having a problem on our end."
                self.errorMessageLine2LabelOutlet.text = "Please try again later."
            }
        }
        
        
    }
    
    // MARK: - Helper Methods
    
    // move view up to accommodate keyboard presentaiton
    func moveViewUp() {
        
        if userMessageStackViewTopConstraint.constant != originalTopMarginForUserMessageStackView {
            return
        }
        userMessageStackViewTopConstraint.constant -= 135
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // move view down to accommodate keyboard presentaiton
    func moveViewDown() {
        if userMessageStackViewTopConstraint.constant == originalTopMarginForUserMessageStackView {
            return
        }
        userMessageStackViewTopConstraint.constant = originalTopMarginForUserMessageStackView
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
extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveViewUp()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveViewDown()
    }
}
