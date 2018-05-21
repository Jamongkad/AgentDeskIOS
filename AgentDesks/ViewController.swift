//
//  ViewController.swift
//  AgentDesks
//
//  Created by Mathew Wong on 5/17/18.
//  Copyright © 2018 yidgetsoft. All rights reserved.
//
    
import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {

    var propertyTableView: PropertyTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Property Picker"
        self.view.backgroundColor = .white

        let d = APIDataService()
        d.process()

        d.coreDataService.finalDataChanged.subscribe(onNext: { dictionary in
            if dictionary["exclusions"] != nil && dictionary["facilities"] != nil {

                self.propertyTableView = PropertyTableViewController()
                self.propertyTableView?.items = dictionary["facilities"] as! [NSMutableDictionary]
                self.propertyTableView?.view.removeFromSuperview()
                self.propertyTableView?.didMove(toParentViewController: self)

                self.view.addSubview(self.propertyTableView!.view)

                self.propertyTableView?.view.snp.makeConstraints({ (make) in
                    make.edges.equalTo(self.view)
                })

                self.propertyTableView?.selectedChange.subscribe(onNext: { (data) in

                    if data["facility_id"] != nil {
                        let detailController: PropertyDetailTableViewController = PropertyDetailTableViewController()
                        detailController.property = data
                        self.navigationController?.pushViewController(detailController, animated: true)
                    }
                })

                self.propertyTableView?.tableView.reloadData()
            }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //A bit of a code smell on my part. If I had more time I can move the validation logic somewhere else.
        self.propertyTableView?.tableView.reloadData()
        let exclusionValidator = ExclusionValidator()
        exclusionValidator.validate()
        exclusionValidator.validationErrorChange.subscribe(onNext: { (validationCheck) in
            if validationCheck {
                print("validation: ", validationCheck)
                let alert = UIAlertController(title: "Whoops", message: "Sorry, the filter combination is not allowed.", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self.present(alert, animated: true, completion: nil)
            }
        })

    }
}

