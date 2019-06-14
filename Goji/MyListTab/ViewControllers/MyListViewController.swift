//
//  MyListViewController.swift
//  Goji
//
//  Created by Eric Andersen on 10/10/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class MyListViewController: UIViewController  {
    
    // MARK: - Outlets
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var hometownTextField: UITextField!
    @IBOutlet weak var myBioTextView: UITextView!
    @IBOutlet weak var todoCompletedSegmentedControl: UISegmentedControl!
    
    
    var bucketList: [BucketListItem] = [MockDataBucketListItems.item2, MockDataBucketListItems.item6, MockDataBucketListItems.item16, MockDataBucketListItems.item23, MockDataBucketListItems.item17, MockDataBucketListItems.item20]
    var toDoItems: [BucketListItem] = []
    var completedItems: [BucketListItem] = []
    
    var users: [User] = [MockDataUsers.dylon, MockDataUsers.luisa, MockDataUsers.maggie, MockDataUsers.park, MockDataUsers.rodrigo, MockDataUsers.sangita]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        MyListController.shared.filterCompleted(bucketListItems: MyListController.shared.myBucketListItems)
        toDoItems = MyListController.shared.toDoItems
        completedItems = MyListController.shared.completedItems
        bucketList = MyListController.shared.myBucketListItems
        
        profilePicImageView.isUserInteractionEnabled = false
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // MARK: - Actions
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        
        
        
        
    }
    
    @IBAction func changedSegmentController(_ sender: UISegmentedControl) {
        //        let selectedIndex = todoCompletedSegmentedControl.selectedSegmentIndex
        //
        //        switch selectedIndex {
        //
        //        case 0:
        //            // To-Do
        //
        //            // display To-Do BucketList Items
        //        case 1:
        //            // Done
        //            // display Done Bucket List Items
        //        }
    }
    
    @IBAction func addNewItemButtonTapped(_ sender: UIButton) {
        
        
    }
    
    
}

