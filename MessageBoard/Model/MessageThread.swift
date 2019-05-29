//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Dongwoo Pae on 5/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

class MessageThread: Equatable, Codable {
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
                lhs.identifier == rhs.identifier &&
                lhs.messages == rhs.messages
    }
    
    
    required init(from decoder: Decoder) throws {
        
        // 1
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 2
        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let messagesDictionaries = try container.decodeIfPresent([String: Message].self, forKey: .messages)
        
        // 3  -  this does solve the issue in JSON decoding being broken
        let messages = messagesDictionaries?.compactMap({ $0.value }) ?? []  //this only will bring the value of dictionary so if there is no value then it will return nil
        
        // 4 - this is like normal memberwise initializer
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    
    
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
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
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let messages = MessageThread.Message.init(text: text, sender: sender)   //to access to Message object class MessageThread should be acccessible that is why this method is placed within MessageThread class
        
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent("messages").appendingPathExtension("json")   //messages should match MessageThread.messages
        
        // based on this identifier it will be added to - this is same as using firstIndex(of: ) in array.
        // we take in MessageThread as a parameter so we get the identifier through them
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(messages)
        } catch {
            print(error)
            completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            messageThread.messages.append(messages)   //we do not need to add self here because messageThread is a class
            completion(nil)
            }.resume()
    }
    
}
