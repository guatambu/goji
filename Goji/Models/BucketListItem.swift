//
//  BucketListItem.swift
//  Goji
//
//  Created by Michael Guatambu Davis on 6/13/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//


import UIKit

class BucketListItem {
    
    // MARK: - Properties
    
    let uid: String
    let user: User
    let timestamp: Date
    var title: String
    var isComplete: Bool
    var mockPhoto: [UIImage]?
    var photoURLs: [String]?
    var experienceDescription: String?
    
    var firebaseDictionary: [String: Any] {
        return [
            BucketListItemKey.uid: uid,
            BucketListItemKey.user: user,
            BucketListItemKey.timestamp: timestamp,
            BucketListItemKey.title: title,
            BucketListItemKey.isComplete: isComplete,
            BucketListItemKey.photoURLs: photoURLs as Any,
            BucketListItemKey.experienceDescription: experienceDescription as Any
        ]
    }
    
    // MARK: - Firebase Keys
    
    enum BucketListItemKey {
        
        // Top Level Item
        static let bucketListItem = "bucketListItem"
        
        // Properties
        static let uid = "uid"
        static let user = "user"
        static let timestamp = "timestamp"
        static let title = "title"
        static let isComplete = "isComplete"
        static let photoURLs = "photoURLs"
        static let experienceDescription = "experienceDescription"
    }
    
    
    // MARK: - Initialization
    
    // MockData
    init(uid: String,
         user: User,
         timestamp: Date,
         title: String,
         isComplete: Bool,
         mockPhoto: [UIImage]?,
         experienceDescription: String
        ) {
        
        self.uid = uid
        self.user = user
        self.timestamp = timestamp
        self.title = title
        self.isComplete = isComplete
        self.mockPhoto = mockPhoto
        self.experienceDescription = experienceDescription
    }
    
    // Firebase
    init(uid: String,
         user: User,
         timestamp: Date,
         title: String,
         isComplete: Bool,
         photoURLs: [String],
         experienceDescription: String
        ) {
        
        self.uid = uid
        self.user = user
        self.timestamp = timestamp
        self.title = title
        self.isComplete = isComplete
        self.photoURLs = photoURLs
        self.experienceDescription = experienceDescription
    }
    
    
    
    
    
}

// Firebase Initialization
extension BucketListItem {
    convenience init?(bucketListItemDictionary: [String : Any]) {
        guard let uid = bucketListItemDictionary[BucketListItemKey.uid] as? String,
            let user = bucketListItemDictionary[BucketListItemKey.user] as? User,
            let timestamp = bucketListItemDictionary[BucketListItemKey.timestamp] as? Date,
            let title = bucketListItemDictionary[BucketListItemKey.title] as? String,
            let isComplete = bucketListItemDictionary[BucketListItemKey.isComplete] as? Bool,
            let photoURLs = bucketListItemDictionary[BucketListItemKey.photoURLs] as? [String],
            let experienceDescription = bucketListItemDictionary[BucketListItemKey.experienceDescription] as? String else { return nil }
        
        
        self.init(uid: uid,
                  user: user,
                  timestamp: timestamp,
                  title: title,
                  isComplete: isComplete,
                  photoURLs: photoURLs,
                  experienceDescription: experienceDescription)
    }
}

extension BucketListItem: Equatable {
    
    // Equatable Protocol Function
    static func ==(lhs: BucketListItem, rhs: BucketListItem) -> Bool {
        return lhs.uid == rhs.uid
        return lhs.title == rhs.title
    }
}











