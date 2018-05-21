import Foundation
import UIKit

class PropertyDetailTableViewController: UITableViewController {

    var property:NSDictionary?
    private var options = [NSDictionary]()
    private let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        self.options = self.property?["options"] as! [NSDictionary]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
        // Configure the cell...
        let item = self.options[indexPath.row]
        print("Hey: ", item)
        cell.textLabel?.text = item["name"] as? String

        let image = UIImage(named: item["icon"] as! String)
        cell.imageView!.image = image

        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}
