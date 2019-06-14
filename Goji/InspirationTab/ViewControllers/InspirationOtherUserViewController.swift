//
//  InspirationOtherUserViewController.swift
//  Goji
//
//  Created by Eric Andersen on 10/11/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class InspirationOtherUserViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var hometownTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var todoCompletedSegmentedControl: UISegmentedControl!
    
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func messageButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func changedSegmentedControl(_ sender: UISegmentedControl) {
    }
}

