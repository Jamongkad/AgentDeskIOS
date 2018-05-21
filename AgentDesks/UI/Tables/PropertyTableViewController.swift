//
// Created by Mathew Wong on 5/20/18.
// Copyright (c) 2018 yidgetsoft. All rights reserved.
//

import Foundation
import UIKit

class PropertyTableViewController : UITableViewController {

    var items: [NSMutableDictionary] = []
    var cell: PropertyTableViewCell? = nil
    let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
        
        // Configure the cell...
        let item = self.items[indexPath.row]
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator

        cell.textLabel?.text = item["name"] as? String
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You have selected cell #\(self.items[indexPath.row])!")
    }
    
}