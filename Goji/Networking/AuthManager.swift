//
//  AuthManager.swift
//  Goji
//
//  Created by Jason Goodney on 10/9/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    // Create User
    func createAccount(withEmail email: String, password: String, username: String,
                       completion: @escaping (_ user: AuthDataResult?, _ error: Error?) -> Void) {
        Endpoint.auth.createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                print("🔥 Error creating user: \(#function) \(error) \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            let user = authDataResult?.user
            
            // TODO: - Handle User
            completion(authDataResult, nil)
            
        }
    }
    
    // Sign in logged out user
    func signIn(withEmail email: String, password: String,
                compeltion: @escaping (_ success: Bool) -> Void) {
        
        Endpoint.auth.signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                print("🔥 Error signing in user: \(#function) \(error) \(error.localizedDescription)")
                compeltion(false)
                return
            }
            
            guard let user = authDataResult?.user else {
                compeltion(false)
                return
            }
            
            // TODO: - Handle User
        }
    }
    
    // Sign in the user anonymously
    func signInAnonymously(compeltion: @escaping (_ success: Bool) -> Void) {
        Endpoint.auth.signInAnonymously { (authDataResult, error) in
            if let error = error {
                print("🔥 Error signing in an anonymous user: \(#function) \(error) \(error.localizedDescription)")
                compeltion(false)
                return
            }
            
            guard let user = authDataResult?.user else {
                compeltion(false)
                return
            }
            
            // TODO: - Handle User
        }
    }
    
    // Links the current anonymous to a permanent account
    func convertAnonymousUserToPermanentAccount(withEmail email: String, password: String,
                                                compeltion: @escaping (_ success: Bool) -> Void) {
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        Endpoint.auth.currentUser?.linkAndRetrieveData(with: credential, completion: { (authDataResult, error) in
            
            if let error = error {
                print("🔥 Error linking anonymous user to the permanent user credentials: \(#function) \(error) \(error.localizedDescription)")
                compeltion(false)
                return
            }
            
            guard let user = authDataResult?.user else {
                compeltion(false)
                return
            }
            
            // TODO: - Handle User
        })
        
    }
    
    // Log out user
    func logout(compeltion: @escaping (_ success: Bool) -> Void) {
        do {
            try Endpoint.auth.signOut()
            compeltion(true)
        } catch {
            print("👎 Could not log out the user.")
            compeltion(false)
            return
        }
    }
    
    func updatePassword(newPassword password: String,
                        compeltion: @escaping (_ success: Bool) -> Void) {
        Endpoint.auth.currentUser?.updatePassword(to: password, completion: { (error) in
            if let error = error {
                print("Error updating the users password: \(#function) \(error) \(error.localizedDescription)")
                compeltion(false)
                return
            }
            
            
        })
    }
    
    // Send the user a password reset to their email
    func sendPassworReset(toEmail email: String,
                          compeltion: @escaping (_ success: Bool) -> Void) {
        
        Endpoint.auth.sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                print("Error sending the user a password reset email: \(#function) \(error) \(error.localizedDescription)")
                compeltion(false)
                return
            }
        }
    }
}
