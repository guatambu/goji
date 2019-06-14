//
//  BucketListItemComment.swift
//  Goji
//
//  Created by Michael Guatambu Davis on 6/13/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//


import UIKit

class BucketListItemComment {
    
    // MARK: - Properties
    
    let uid: String
    let text: String
    let timestamp: Date
    let user: User
    
    var firebaseDictionary: [String: Any] {
        return [
            BucketListItemCommentKey.uid: uid,
            BucketListItemCommentKey.text: text,
            BucketListItemCommentKey.timestamp: timestamp,
            BucketListItemCommentKey.user: user
        ]
    }
    
    
    // MARK: - Firebase Keys
    
    enum BucketListItemCommentKey {
        
        // Top Level Item
        static let bucketListItemComment = "bucketListItemComment"
        
        // Properties
        static let uid = "uid"
        static let text = "text"
        static let timestamp = "timestamp"
        static let user = "user"
    }
    
    
    // MARK: - Initialization
    
    init(uid: String,
         text: String,
         timestamp: Date,
         user: User
        ) {
        
        self.uid = uid
        self.text = text
        self.timestamp = timestamp
        self.user = user
    }
    
    convenience init?(bucketListItemCommentDictionary: [String : Any]) {
        guard let uid = bucketListItemCommentDictionary[BucketListItemCommentKey.uid] as? String,
            let text = bucketListItemCommentDictionary[BucketListItemCommentKey.text] as? String,
            let timestamp = bucketListItemCommentDictionary[BucketListItemCommentKey.timestamp] as? Date,
            let user = bucketListItemCommentDictionary[BucketListItemCommentKey.user] as? User else { return nil }
        
        self.init(uid: uid,
                  text: text,
                  timestamp: timestamp,
                  user: user)
    }
    
}

extension BucketListItemComment: Equatable {
    
    // Equatable Protocol Function
    static func ==(lhs: BucketListItemComment, rhs: BucketListItemComment) -> Bool {
        return lhs.uid == rhs.uid
    }
}











