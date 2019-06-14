//
//  MyListTableViewCell.swift
//  Goji
//
//  Created by Jason Goodney on 10/24/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class MyListTableViewCell: UITableViewCell, ReuseIdentifiable {
    
    // MARK: - Properties
    var bucketListItem: BucketListItem? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Subviews
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func updateView() {
        guard let item = bucketListItem else { return }
        
        titleLabel.text = item.title
    }
    
}

