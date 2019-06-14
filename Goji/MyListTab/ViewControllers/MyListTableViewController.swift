//
//  MyListTableViewController.swift
//  Goji
//
//  Created by Michael Guatambu Davison 10/18/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class MyListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var bucketListMainLabelOutlet: UILabel!
    @IBOutlet weak var segmentedControlOutlet: DesignableSegmentedControl!
    @IBOutlet weak var addItemButtonOutlet: DesignableButton!
    @IBOutlet weak var addNewItemLabelOutlet: UILabel!
    
    var user: User?
    
    var bucketList: [BucketListItem] = [MockDataBucketListItems.item2, MockDataBucketListItems.item6, MockDataBucketListItems.item16, MockDataBucketListItems.item23, MockDataBucketListItems.item17, MockDataBucketListItems.item20]
    var displayedBucketItems: [BucketListItem] = []
    var toDoItems: [BucketListItem] = []
    var completedItems: [BucketListItem] = []
    
    let dylon = MockDataUsers.dylon
    
    
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        
        // ready arrays of userdata for display
        MyListController.shared.filterCompleted(bucketListItems: bucketList)
        toDoItems = MyListController.shared.toDoItems
        completedItems = MyListController.shared.completedItems
        bucketList = MyListController.shared.myBucketListItems
        
        // add round profile pic as button
        let squareDimensions: CGFloat = 40.0
        let button = UIButton.init(type: .custom)
        button.setImage(dylon.mockProfilePic, for: UIControl.State.normal)
        
        button.widthAnchor.constraint(equalToConstant: squareDimensions).isActive = true
        button.heightAnchor.constraint(equalToConstant: squareDimensions).isActive = true
        guard let buttonImageView = button.imageView else { return }
        buttonImageView.layer.cornerRadius = 0.5 * squareDimensions
        buttonImageView.clipsToBounds = true
        
        // add action to the button
        button.addTarget(self, action: #selector(profileButtonTapped(sender:)), for: .touchUpInside)
        
        // add to left nav bar button item
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        
        // set TVC title to user.username
        self.title = dylon.username
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Actions
    
    @objc func profileButtonTapped(sender: UIButton) {
        print("test")
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "MyList", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toUserProfileDetail") as! UserProfileDetailViewController
        // create the segue programmatically
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        backButtonItem.tintColor = UIColor.black
        
        // mockdata for user
        user = dylon
        // pass any desired info to new ViewController
        destViewController.user = user
    }
    
    @IBAction func changedSegmentedController(_ sender: UISegmentedControl) {
        let selectedIndex = segmentedControlOutlet.selectedSegmentIndex
        
        switch selectedIndex {
            
        case 0:
            // To-Do
            print("0 - ToDo")
        // display To-Do BucketList Items
        case 1:
            // Done
            print("1 - Completed")
        // display Done Bucket List Items
        default:
            print("not an acceptable choice from the two segmented controller options in MyListTableViewController.swift")
        }
    }
    
    
    @IBAction func addNewItemButtonTapped(_ sender: DesignableButton) {
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.reuseIdentifier, for: indexPath)
        
        
        return cell
    }
    
    
}
