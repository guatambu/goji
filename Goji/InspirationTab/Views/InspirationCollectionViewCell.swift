//
//  InspirationCollectionViewCell.swift
//  Goji
//
//  Created by Eric Andersen on 10/11/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class InspirationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var inspirationImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var inspirationView: UIView!
    
    
    var bucketListItem: BucketListItem? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inspirationView.layer.cornerRadius = 6
        inspirationView.layer.masksToBounds = true
        inspirationImageView.layer.cornerRadius = 6
        inspirationImageView.layer.masksToBounds = true
        inspirationImageView.layer.shadowColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        inspirationImageView.layer.shadowRadius = 3
        inspirationImageView.layer.shadowOpacity = 1
        inspirationImageView.layer.shadowOffset = CGSize(width: 30, height: 40)
        
        itemTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    func updateViews() {
        guard let bucketListItem = bucketListItem else { return }
        inspirationImageView.image = bucketListItem.mockPhoto?.first
        itemTitleLabel.text = bucketListItem.title
    }
    
    
    @IBAction func quickAddButtonTapped(_ sender: UIButton) {
    }
}
