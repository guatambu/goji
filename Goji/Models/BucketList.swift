//
//  BucketList.swift
//  Goji
//
//  Created by Michael Guatambu Davis on 6/13/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//


import UIKit

class BucketList {
    
    // MARK: - Properties
    
    var items: [BucketListItem]
    var isPrivate: Bool
    
    var firebaseDictionary: [String: Any] {
        return [
            BucketListKey.items: items,
            BucketListKey.isPrivate: isPrivate
        ]
    }
    
    // MARK: - Firebase Keys
    
    enum BucketListKey {
        
        // Top Level Item
        static let bucketList = "bucketList"
        
        // Properties
        static let items = "items"
        static let isPrivate = "isPrivate"
    }
    
    
    // MARK: - Initialization
    
    init(items: [BucketListItem], isPrivate: Bool) {
        
        self.items = items
        self.isPrivate = isPrivate
    }
    
    convenience init?(bucketListDictionary: [String : Any]) {
        guard let items = bucketListDictionary[BucketListKey.items] as? [BucketListItem],
            let isPrivate = bucketListDictionary[BucketListKey.isPrivate] as? Bool else { return nil }
        
        self.init(items: items,
                  isPrivate: isPrivate)
    }
}

extension BucketList: Equatable {
    
    // Equatable Protocol Function
    static func ==(lhs: BucketList, rhs: BucketList) -> Bool {
        return lhs.items == rhs.items && lhs.isPrivate == rhs.isPrivate
    }
}









