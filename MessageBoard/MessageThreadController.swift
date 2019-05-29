//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Dongwoo Pae on 5/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")! //you must call MessageThreadController to access to baseURL
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
       
        let messageThread = MessageThread(title: title)
        
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(messageThread)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (_, _, error) in
            if let error = error {
                NSLog("Error : \(error)")
                completion(error)
                return
            }
           
            self.messageThreads.append(messageThread)
            completion(nil)
            }.resume()
        }
    }
