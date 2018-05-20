//
//  FacilityOptions+CoreDataProperties.swift
//  AgentDesks
//
//  Created by Mathew Wong on 5/19/18.
//  Copyright © 2018 yidgetsoft. All rights reserved.
//
//

import Foundation
import CoreData


extension FacilityOptions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FacilityOptions> {
        return NSFetchRequest<FacilityOptions>(entityName: "FacilityOptions")
    }

    @NSManaged public var id: String?
    @NSManaged public var option_name: String?
    @NSManaged public var icon: String?
    @NSManaged public var facilities: Facilities?

}
