//
//  User.swift
//  Goji
//
//  Created by Michael Guatambu Davis on 6/13/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class User {
    
    // MARK: - Properties
    
    let uid: String
    let email: String
    let username: String
    let password: String
    var isPrivate: Bool
    var firstName: String?
    var lastName: String?
    var mockProfilePic: UIImage?
    var profileImageURL: String?
    var location: String?
    var age: String?
    var bioBlurb: String?
    
    var fullName: String {
        guard let firstName = firstName, let lastName = lastName else { return "" }
        return "\(firstName) \(lastName)"
    }
    
    var firebaseDictionary: [String: Any] {
        return [
            UserKey.uid: uid,
            UserKey.email: email,
            UserKey.username: username,
            UserKey.password: password,
            UserKey.isPrivate: isPrivate,
            UserKey.firstName: firstName as Any,
            UserKey.lastName: lastName as Any,
            UserKey.profileImageURL: profileImageURL as Any,
            UserKey.location: location as Any,
            UserKey.age: age as Any
        ]
    }
    
    
    // MARK: - Firebase Keys
    
    enum UserKey {
        
        // Top Level Item
        static let users = "users"
        
        // Properties
        static let uid = "uid"
        static let email = "email"
        static let username = "username"
        static let password = "password"
        static let isPrivate = "isPrivate"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let profileImageURL = "profileImageURL"
        static let location = "location"
        static let age = "age"
    }
    
    // MARK: - Initialization
    
    // MockData
    init(uid: String,
         email: String,
         username: String,
         password: String,
         isPrivate: Bool,
         firstName: String?,
         lastName: String?,
         mockProfilePic: UIImage?,
         location: String?,
         age: String?,
         bioBlurb: String? = ""
        ) {
        
        self.uid = uid
        self.email = email
        self.username = username
        self.password = password
        self.isPrivate = isPrivate
        self.firstName = firstName
        self.lastName = lastName
        self.mockProfilePic = mockProfilePic
        self.location = location
        self.age = age
        self.bioBlurb = bioBlurb
    }
    
    // Firebase
    init(uid: String,
         email: String,
         username: String,
         password: String,
         isPrivate: Bool,
         firstName: String?,
         lastName: String?,
         profileImageURL: String?,
         location: String?,
         age: String?
        ) {
        
        self.uid = uid
        self.email = email
        self.username = username
        self.password = password
        self.isPrivate = isPrivate
        self.firstName = firstName
        self.lastName = lastName
        self.profileImageURL = profileImageURL
        self.location = location
        self.age = age
    }
    
}

// Firebase Initializer
extension User {
    
    convenience init?(userDictionary: [String : Any]) {
        guard let uid = userDictionary[UserKey.uid] as? String,
            let email = userDictionary[UserKey.email] as? String,
            let username = userDictionary[UserKey.username] as? String,
            let password = userDictionary[UserKey.password] as? String,
            let isPrivate = userDictionary[UserKey.isPrivate] as? Bool,
            let firstName = userDictionary[UserKey.firstName] as? String,
            let lastName = userDictionary[UserKey.lastName] as? String,
            let profileImageURL = userDictionary[UserKey.profileImageURL] as? String,
            let location = userDictionary[UserKey.location] as? String,
            let age = userDictionary[UserKey.age] as? String else { return nil }
        
        self.init(uid: uid,
                  email: email,
                  username: username,
                  password: password,
                  isPrivate: isPrivate,
                  firstName: firstName,
                  lastName: lastName,
                  profileImageURL: profileImageURL,
                  location: location,
                  age: age)
    }
}

extension User: Equatable {
    
    // Equatable Protocol Function
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }
}



