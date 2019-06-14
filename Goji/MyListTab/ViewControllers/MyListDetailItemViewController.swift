//
//  MyListDetailItemViewController.swift
//  Goji
//
//  Created by Eric Andersen on 10/10/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class MyListDetailItemViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var additionalInfoTextView: UITextView!
    
    
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
    @IBAction func collapseButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func publicPrivateSwitchButtonTapped(_ sender: UISwitch) {
    }
    
    @IBAction func tipsPageButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
    }
}
