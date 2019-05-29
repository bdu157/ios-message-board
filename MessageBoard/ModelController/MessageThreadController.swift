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
    
    static let baseURL = URL(string: "https://message-board-b0673.firebaseio.com/")! //you must call MessageThreadController to access to baseURL
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
       
        let messageThread = MessageThread.init(title: title)   //we initialize here so we can create new data and we have access to identifier for the "location"
        
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
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error : \(error)")
                completion(error)
                return
            }
           
            self.messageThreads.append(messageThread)
            completion(nil)
            
            }.resume()
        }
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
        let url = MessageThreadController.baseURL.appendingPathExtension("json") //this is only necessary when using firebase as the API
        
        //I dont need to do this part below since default httpMethod is GET if you dont specifically set them up.
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) {(data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                //At the highest level, the MessageThreads are the values of UUID string keys
                let messageThreadDictionaries = try jsonDecoder.decode([String:MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map {$0.value}
                //this could also be written Array(messageThreadDictionaries.values)
                self.messageThreads = messageThreads
                completion(nil)
            } catch {
                print("Error decoding received data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
}
