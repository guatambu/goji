//
//  Endpoint.swift
//  Goji
//
//  Created by Jason Goodney on 10/9/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct Endpoint {
    
    // Firebase endpoints properties
    private static let _auth = Auth.auth()
    private static let _storageRef = Storage.storage().reference()
    private static let _database = Firestore.firestore()
    
    private init() {}
    
    // App facing endpoint properties
    static var auth: Auth {
        return Endpoint._auth
    }
    
    static var storageRef: StorageReference {
        return Endpoint._storageRef
    }
    
    static var database: Firestore {
        return Endpoint._database
    }
    
    // Firestore Collection endpoints
    struct Collection {
        private static let _users = "users"
        private static let _items = "items"
        private static let _messages = "messages"
        private static let _comments = "comments"
        private static let _categories = "categories"
        
        static var users: CollectionReference {
            return Endpoint.database.collection(_users)
        }
        
        static var items: CollectionReference {
            return Endpoint.database.collection(_items)
        }
        
        static var messages: CollectionReference {
            return Endpoint.database.collection(_messages)
        }
        
        static var comments: CollectionReference {
            return Endpoint.database.collection(_comments)
        }
        
        static var categories: CollectionReference {
            return Endpoint.database.collection(_categories)
        }
    }
    
    // Firebase storage bucket paths
    /*
     StorageBucket
     images
     uid
     profileImage
     *.jpg
     itemImages
     *.jpg
     */
    struct StorageBucket {
        private static let _images = "images"
        private static let _profileImage = "profile"
        private static let _itemImages = "item"
        
        static var images: StorageReference {
            return Endpoint.storageRef.child(_images)
        }
        
        static func profileImage(forUid uid: String) -> StorageReference {
            return images.child(uid).child(_profileImage)
        }
        
        static func itemImages(forUid uid: String) -> StorageReference {
            return images.child(uid).child(_itemImages)
        }
        
        
    }
    
}
