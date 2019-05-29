//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Dongwoo Pae on 5/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = messageThread?.title
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThread?.messages.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let text = messageThread?.messages[indexPath.row]
        let sender = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = text?.text
        cell.detailTextLabel?.text = sender?.sender
        return cell
    }
 

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMDetailVC" {
            guard let destVC = segue.destination as? MessageDetailViewController else {return}
                destVC.messageThreadController = self.messageThreadController
                destVC.messageThread = self.messageThread
        }
    }

}
