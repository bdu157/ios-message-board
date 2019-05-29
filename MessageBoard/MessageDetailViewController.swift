//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Dongwoo Pae on 5/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Message"
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }

    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            let messageInput = textView.text,
            let messageThreadInput = messageThread else {return}
        messageThread?.createMessage(messageThread: messageThreadInput, text: messageInput, sender: name) { (error) in
            if let error =  error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
