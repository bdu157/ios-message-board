//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Dongwoo Pae on 5/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    var messsageThreadController: MessageThreadController = MessageThreadController()
    
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messsageThreadController.messageThreads.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let messageThread = messsageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMTDetailTableVC" {
            guard let destVC = segue.destination as? MessageThreadDetailTableViewController,
                let selectedRow = self.tableView.indexPathForSelectedRow else {return}
                destVC.messageThreadController = self.messsageThreadController
                destVC.messageThread = self.messsageThreadController.messageThreads[selectedRow.row]
        }
    }

    
    @IBAction func textFieldAction(_ sender: Any) {
        guard let textInput = textField.text else {return}
        messsageThreadController.createMessageThread(title: textInput) { (error) in
            if let error = error {
                print(error)
                return
                
            } else {
                
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.textField.text = nil
                }
            }
        }
    }
    
}
