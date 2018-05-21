import Foundation
import UIKit
import CoreData

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
        cell.textLabel?.text = item["name"] as? String

        let image = UIImage(named: item["icon"] as! String)
        cell.imageView!.image = image

        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = self.options[indexPath.row]

        let facility_id = self.property?["facility_id"] as! String

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserList")
        fetchRequest.predicate = NSPredicate(format: "facility_id = %@", facility_id)

        do {
            let list = try PersistenceService.context.fetch(fetchRequest) as? [NSManagedObject]
            if list!.count == 0 {
                let userList = UserList(context: PersistenceService.context)
                userList.facility_id = facility_id
                userList.option_id = option["id"] as? String
            } else {
                list![0].setValue(option["id"], forKey: "option_id")
            }

        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }

        PersistenceService.saveContext()
    }

}
