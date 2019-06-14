//
//  MessageListTableViewCell.swift
//  Goji
//
//  Created by Jason Goodney on 10/15/18.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import MessageKit

class MessageListCell: UITableViewCell, ReuseIdentifiable {
    
    // MARK: - Properties
    var message: Message? {
        didSet {
            updateMessageDetails()
        }
    }
    
    var conversation: Conversation? {
        didSet {
            updateConversationDetails()
        }
    }
    
    var chatPartner: User? {
        return conversation?.chatPartner
    }
    
    // MARK: - Subviews
    @IBOutlet weak var messageGlimpseLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        updateView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateView() {
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        messageGlimpseLabel.font = UIFont.systemFont(ofSize: 14)
        messageGlimpseLabel.textColor = .lightGray
    }
    
    func updateUserDetails() {
        guard let chatPartner = chatPartner else { return }
        
        profileImageView.image = chatPartner.mockProfilePic
        usernameLabel.text = chatPartner.username
        
        roundImageView()
        
    }
    
    func updateMessageDetails() {
        guard let message = message else { return }
        guard let chatPartner = chatPartner else { return }
        
        if message.sender.displayName != chatPartner.username {
            messageGlimpseLabel.text = "You: \(message.text)"
        } else {
            messageGlimpseLabel.text = "\(message.text)"
        }
        
        updateUserDetails()
    }
    
    func updateConversationDetails() {
        guard let conversation = conversation else { return }
        guard let chatPartner = chatPartner else { return }
        let message = conversation.mostRecentMessage
        
        if message.sender.displayName != chatPartner.username {
            messageGlimpseLabel.text = "You: \(message.text)"
        } else {
            messageGlimpseLabel.text = "\(message.text)"
        }
        
        updateUserDetails()
    }
    
    
    func roundImageView() {
        let imageViewHeight = profileImageView.bounds.height
        
        profileImageView.layer.cornerRadius = imageViewHeight / 2
        
        profileImageView.clipsToBounds = true
    }
}



