//
// Created by Mathew Wong on 5/20/18.
// Copyright (c) 2018 yidgetsoft. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PropertyTableViewController : UITableViewController {

    var items: [NSMutableDictionary] = []
    var cell: PropertyTableViewCell? = nil
    let cellID = "UITableViewCell"

    private let selected = Variable<NSDictionary>([:])
    var selectedChange:Observable<NSDictionary> {
        return selected.asObservable()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let reuseId = "FancyCell"

        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId) else {
                return UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: reuseId)
            }
            return cell
        }()

        let item = self.items[indexPath.row]

        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = item["name"] as? String
        cell.detailTextLabel?.text = "Value"

        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected.value = self.items[indexPath.row]
    }
    
}
