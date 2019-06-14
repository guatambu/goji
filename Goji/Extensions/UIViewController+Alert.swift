//
//  UIViewController+Alert.swift
//  Goji
//
//  Created by Jason Goodney on 10/20/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentJustOkAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

