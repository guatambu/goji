//
//  Message.swift
//  Goji
//
//  Created by Michael Guatambu Davis on 6/13/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//


import UIKit
import MessageKit

class Message {
    
    // MARK: - Properties
    
    let uid: String
    let sentFrom: User
    var receiver: User
    let text: String
    let timestamp: Date
    
    
    var firebaseDictionary: [String: Any] {
        return [
            MessageKey.uid: uid,
            MessageKey.sender: sender,
            MessageKey.receiver: receiver,
            MessageKey.text: text,
            MessageKey.timestamp: timestamp,
        ]
    }
    
    // MARK: - Firebase Keys
    
    enum MessageKey {
        
        // Top Level Item
        static let message = "message"
        
        // Properties
        static let uid = "uid"
        static let sender = "sender"
        static let receiver = "receiver"
        static let text = "text"
        static let timestamp = "timestamp"
    }
    
    
    // MARK: - Initialization
    
    init(uid: String,
         sentFrom: User,
         receiver: User,
         text: String,
         timestamp: Date
        ) {
        
        self.uid = uid
        self.sentFrom = sentFrom
        self.receiver = receiver
        self.text = text
        self.timestamp = timestamp
        
    }
    
    convenience init?(messageDictionary: [String : Any]) {
        guard let uid = messageDictionary[MessageKey.uid] as? String,
            let sentFrom = messageDictionary[MessageKey.sender] as? User,
            let receiver = messageDictionary[MessageKey.receiver] as? User,
            let text = messageDictionary[MessageKey.text] as? String,
            let timestamp = messageDictionary[MessageKey.timestamp] as? Date else { return nil }
        
        self.init(uid: uid,
                  sentFrom: sentFrom,
                  receiver: receiver,
                  text: text,
                  timestamp: timestamp)
    }
    
    
}

extension Message: MessageType {
    var sender: Sender {
        get {
            return Sender(id: sentFrom.uid, displayName: sentFrom.username)
        }
        set (newSender) {
            self.sender = newSender
        }
    }
    
    var messageId: String {
        
        return uid
    }
    
    var sentDate: Date {
        
        return timestamp
    }
    
    var kind: MessageKind {
        return .text(text)
    }
}

extension Message: Equatable {
    
    // Equatable Protocol Function
    static func ==(lhs: Message, rhs: Message) -> Bool {
        return lhs.uid == rhs.uid
    }
}









