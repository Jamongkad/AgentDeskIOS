//
// Created by Mathew Wong on 5/20/18.
// Copyright (c) 2018 yidgetsoft. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class APICoreDataService {

    var data: NSMutableDictionary = [:]
    var facilities = [Facilities]()
    var exclusionList = [ExclusionList]()

    let finalData = Variable<NSMutableDictionary>([:])
    var finalDataChanged:Observable<NSMutableDictionary> {
        return finalData.asObservable()
    }

    func fetchData() {
        do {

            print("Fetching")

            let facilitiesRequest: NSFetchRequest<Facilities> = Facilities.fetchRequest()
            let exclusionsRequest: NSFetchRequest<ExclusionList> = ExclusionList.fetchRequest()

            facilities = try PersistenceService.context.fetch(facilitiesRequest)
            exclusionList = try PersistenceService.context.fetch(exclusionsRequest)

            var facilityCollection = [NSMutableDictionary]()
            for fac in facilities {
                let facilityObj: NSMutableDictionary = [:]

                facilityObj["facility_id"] = fac.facility_id as! String
                facilityObj["name"] = fac.facility_name as! String

                let options: NSOrderedSet! = fac.options
                var optionCollection = [[String:String]]()
                for o in options {
                    let op = o as! FacilityOptions

                    var optionObj = [String:String]()

                    optionObj["id"] = op.id
                    optionObj["name"] = op.option_name
                    optionObj["icon"] = op.icon

                    optionCollection.append(optionObj)
                }

                facilityObj["options"] = optionCollection
                facilityCollection.append(facilityObj)
            }

            self.data["facilities"] = facilityCollection

            var exclusionCollection = [[[String:String]]]()

            for exc in exclusionList {
                let exclusion: NSOrderedSet! = exc.exclusions
                var exclusionList = [[String:String]]()

                for e in exclusion {
                    let ex = e as! Exclusions

                    var exclusionObj = [String:String]()
                    exclusionObj["facility_id"] = ex.facility_id
                    exclusionObj["options_id"] = ex.option_id
                    exclusionList.append(exclusionObj)
                }

                exclusionCollection.append(exclusionList)
            }

            self.data["exclusions"] = exclusionCollection
        } catch let error as NSError {
            print("Unexpected error: \(error).")
        }

        self.finalData.value = self.data
    }
}
