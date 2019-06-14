//
//  MyBucketNewItemViewController.swift
//  Goji
//
//  Created by Eric Andersen on 10/10/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class MyBucketNewItemViewController: UIViewController {
    
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
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
