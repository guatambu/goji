//
//  MyListNewItemViewController.swift
//  Goji
//
//  Created by Eric Andersen on 10/10/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class MyListNewItemViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var addTagsTextField: UITextField!
    @IBOutlet weak var additionalInfoTextView: UITextView!
    
    
    // MARK: - Lifecycle Functions
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
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func publicPrivateSwitchTapped(_ sender: UISwitch) {
    }
    
    @IBAction func colorPickerButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
    }
}
