//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Dongwoo Pae on 5/28/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
 


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    
    @IBAction func textFieldAction(_ sender: Any) {
        
    }
    
    
    
}
