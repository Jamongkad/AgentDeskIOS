//
// Created by Mathew Wong on 5/21/18.
// Copyright (c) 2018 yidgetsoft. All rights reserved.
//

import Foundation
import CoreData

class SelectedLabel {
    func label(facilityId: String, options: Array<NSDictionary>) -> String {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserList")
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.predicate = NSPredicate(format: "facility_id = %@", facilityId)

        do {

            let list = try PersistenceService.context.fetch(fetchRequest)
            if list.count != 0 {
                let userOption = list[0] as! NSDictionary
                let chosenOption = (options).filter { (v) -> Bool in
                    return (v as! NSDictionary)["id"] as! String == userOption["option_id"] as! String
                }

                return (chosenOption[0] as! NSDictionary)["name"] as! String
            }


        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        return ""
    }
}
