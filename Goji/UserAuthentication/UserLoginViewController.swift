//
//  UserLoginViewController.swift
//  Goji
//
//  Created by Michael Guatambu Davis on 10/12/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class UserLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var loginLabelOutlet: UILabel!
    @IBOutlet weak var emailUsernameLabelOutlet: UILabel!
    @IBOutlet weak var emailUsernameTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var dontHaveAccountLabelOutlet: UILabel!
    @IBOutlet weak var errorMessageStackViewOutlet: UIStackView!
    @IBOutlet weak var errorLine1LabelOutlet: UILabel!
    @IBOutlet weak var errorLine2LabelOutlet: UILabel!
    
    // relevant constraints
    @IBOutlet weak var userMessageStackViewTopConstraint: NSLayoutConstraint!
    let originalTopMarginForUserMessageStackView: CGFloat = 16
    
    // relevant instances
    let authManager = AuthManager()
    
    // mockData local data source
    var users = [MockDataUsers.dylon, MockDataUsers.luisa, MockDataUsers.maggie, MockDataUsers.park, MockDataUsers.rodrigo, MockDataUsers.sangita]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        errorMessageStackViewOutlet.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dismiss keyboard when tap anywhere on screen
        self.hideKeyboardOnRandomScreenTap()
    }
    
    
    // MARK: - Actions
    
    @IBAction func xCloseButtonTapped(_ sender: Any) {
        // pop viewController
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func forgotButtonTapped(_ sender: UIButton) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "UserAuthentication", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toForgotPassword")
        // create the modal segue programmatically
        self.present(destViewController, animated: true, completion: nil)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = "Login"
        navigationItem.backBarButtonItem = backButtonItem
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        guard let emailUsername = emailUsernameTextFieldOutlet.text, emailUsernameTextFieldOutlet.text != "" else {
            
            errorMessageStackViewOutlet.isHidden = false
            errorLine1LabelOutlet.text = "Please enter your email address."
            
            return
        }
        
        guard let password = passwordTextFieldOutlet.text, passwordTextFieldOutlet.text != "" else {
            
            errorMessageStackViewOutlet.isHidden = false
            errorLine1LabelOutlet.text = "Please enter your password."
            
            return
        }
        
        // **** START    mock data solution
        for user in users {
            
            if (emailUsername != user.email) {
                
                errorMessageStackViewOutlet.isHidden = false
                errorLine1LabelOutlet.text = "We do not recognize your email address."
                errorLine2LabelOutlet.text = "Please try again."
                
            } else if (emailUsername == user.email) && (password != user.password) {
                
                errorMessageStackViewOutlet.isHidden = false
                errorLine1LabelOutlet.text = "We do not recoginze your password."
                errorLine2LabelOutlet.text = "Please check your password and try again."
                
            } else if (emailUsername == user.email) && (password == user.password) {
                
                print("login successful")
                
                UserController.shared.isUserLoggedIn = true
                
                // pop viewController
                self.navigationController?.popViewController(animated: true)
            }
        }
        // ***** END mock data solution
        
        // ***** START firebase solution
        
        authManager.signIn(withEmail: emailUsername, password: password) { (success) in
            
            if success {
                
                // toggle isUserLoggedIn property upon success
                UserController.shared.isUserLoggedIn = true
                
                // return user to where they were in the nav stack
                // pop viewController
                self.navigationController?.popViewController(animated: true)
            } else {
                
                self.errorMessageStackViewOutlet.isHidden = false
                self.errorLine1LabelOutlet.text = "Apologies. We may be having a problem on our end."
                self.errorLine2LabelOutlet.text = "Please try again later."
            }
        }
        
        // ***** END firebase solution
        
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "UserAuthentication", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUserCreateAccount")
        // create the modal segue programmatically
        self.present(destViewController, animated: true, completion: nil)
        // set the desired properties of the destinationVC's navgation Item
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
extension UserLoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveViewUp()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveViewDown()
    }
}


// MARK: - Dismiss keyboard via tap anywhere gesture recognizer

extension UIViewController {
    func hideKeyboardOnRandomScreenTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

