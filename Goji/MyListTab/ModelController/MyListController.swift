//
//  MyListController.swift
//  Goji
//
//  Created by Michael Guatambu Davis on 10/17/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

class MyListController {
    
    // MARK - Properties
    
    static var shared = MyListController()
    
    var myBucketListItems: [BucketListItem] = []
    
    var completedItems: [BucketListItem] = []
    
    var toDoItems: [BucketListItem] = []
    
    
    // MARK: CRUD Functions
    
    // Create - no need to create one.  user gets one and only one by default.
    
    // Read
    
    // Update
    
    func addItemToBucketList(_ item: BucketListItem) {
        myBucketListItems.append(item)
    }
    
    // Delete
    
    func deleteItemFromBucketList(_ item: BucketListItem) {
        guard let index = self.myBucketListItems.index(of: item) else { return }
        self.myBucketListItems.remove(at: index)
        
    }
    
    
    // MARK: - Helper Methods
    
    func filterCompleted(bucketListItems: [BucketListItem]) {
        
        if !bucketListItems.isEmpty {
            
            for item in bucketListItems {
                if item.isComplete {
                    completedItems.append(item)
                } else {
                    toDoItems.append(item)
                }
            }
        }
    }
    
}

