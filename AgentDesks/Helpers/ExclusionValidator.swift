//
// Created by Mathew Wong on 5/21/18.
// Copyright (c) 2018 yidgetsoft. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class ExclusionValidator {

    private let validationError = Variable(false)
    var validationErrorChange:Observable<Bool> {
        return validationError.asObservable()
    }

    func validate() {

        let coreDataService = APICoreDataService()
        coreDataService.fetchData()
        coreDataService.finalDataChanged.subscribe(onNext: { dictionary in

            //Here be dragons in this part...
            do {
                let userListRequest: NSFetchRequest<UserList> = UserList.fetchRequest()
                let list = try PersistenceService.context.fetch(userListRequest)
                if list.count != 0 {

                    var userListContainer = [NSDictionary]()
                    for choice in list {
                        let userListObj: NSDictionary = ["facility_id": choice.facility_id as! String, "options_id": choice.option_id as! String]
                        userListContainer.append(userListObj)
                    }

                    for exclusion in dictionary["exclusions"] as! NSArray {
                        var exclusionList = [NSDictionary]()
                        for e in exclusion as! NSArray {
                            let exclusionObj = e as! NSDictionary
                            exclusionList.append(exclusionObj)
                        }

                        var total = userListContainer + exclusionList
                        var g = [NSDictionary]()
                        for (index, element) in total.enumerated().reversed() {
                            if total.filter({ $0 == element}).count > 1 {
                                g.append(total[index])
                                total.remove(at: index)
                            }
                        }

                        g = g.sorted(by: { $0["facility_id"] as! String > $1["facility_id"] as! String })
                        exclusionList = exclusionList.sorted(by: { $0["facility_id"] as! String > $1["facility_id"] as! String })

                        if(g == exclusionList) {
                            print("validation error")

                            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserList")
                            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

                            do {
                                try PersistenceService.context.execute(deleteRequest)
                            } catch let error as NSError {
                                print(error)
                            }

                            self.validationError.value = true
                        }
                    }
                }
            } catch let error as NSError {
                print("Fetch failed: \(error.localizedDescription)")
            }
        })
    }
}
