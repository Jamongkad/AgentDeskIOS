//
// Created by Mathew Wong on 5/20/18.
// Copyright (c) 2018 yidgetsoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class APIDataRequestService {

    func requestDataFromAPI(completion: (() -> Void)!) {

        //let's clear data before we make a request for a fresh batch.
        self.reset(entity: "Facilities")
        self.reset(entity: "ExclusionList")

        Alamofire.request(AppConstants.Domains.Prod).responseJSON { response in
            switch response.result {
            case .success:
                guard let resultValue = response.result.value else {
                    NSLog("Result value in response is nil")
                    return
                }

                let json = JSON(resultValue)

                for (_, facility) in json["facilities"] {

                    let f = Facilities(context: PersistenceService.context)
                    f.facility_name = facility["name"].stringValue
                    f.facility_id = facility["facility_id"].stringValue
                    for(_, option) in facility["options"] {
                        let o = FacilityOptions(context: PersistenceService.context)
                        o.id = option["id"].stringValue
                        o.option_name = option["name"].stringValue
                        o.icon = option["icon"].stringValue
                        f.addToOptions(o)
                    }

                    PersistenceService.saveContext()
                }

                for (_, exclusion) in json["exclusions"] {
                    let el = ExclusionList(context: PersistenceService.context)
                    el.exclusion = NSUUID().uuidString
                    for (_, echild) in exclusion {
                        let e = Exclusions(context: PersistenceService.context)
                        e.facility_id = echild["facility_id"].stringValue
                        e.option_id = echild["options_id"].stringValue
                        el.addToExclusions(e)
                    }
                    PersistenceService.saveContext()
                }

                completion?()

            case .failure(let error):
                print("Error: ", error)
            }
        }
    }

    func reset(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            //Reset Storage for new fresh request.
            try PersistenceService.context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
