//
//  InspirationPersonalizedAddedItemViewController.swift
//  Goji
//
//  Created by Eric Andersen on 10/18/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class InspirationPersonalizeAddedItemViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var goalNameTextField: UITextField!
    @IBOutlet weak var addTagsTextField: UITextField!
    @IBOutlet weak var changePhotoTextView: UITextView!
    
    
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
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToListButtonTapped(_ sender: UIButton) {
        //TODO: Create list item and append it to source of truth
        print(self.presentingViewController)
        let presentingView1 = self.presentingViewController
        let presentingView2 = self.presentingViewController?.presentingViewController
        self.navigationController?.dismiss(animated: true, completion: {
            presentingView1?.dismiss(animated: true, completion: {
                presentingView2?.dismiss(animated: true, completion: nil)
            })
        })
        
    }
}
