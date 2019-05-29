//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Dongwoo Pae on 5/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

class MessageThred: Equatable, Codable {
    static func == (lhs: MessageThred, rhs: MessageThred) -> Bool {
        return lhs.title == rhs.title &&
                lhs.identifier == rhs.identifier &&
                lhs.messages == rhs.messages
    }
    
    let title: String
    let identifier: String
    var messages: [MessageThred.Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThred.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text:String, sender:String, timestamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
        
    }
}
