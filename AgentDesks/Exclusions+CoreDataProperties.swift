//
//  Exclusions+CoreDataProperties.swift
//  AgentDesks
//
//  Created by Mathew Wong on 5/19/18.
//  Copyright © 2018 yidgetsoft. All rights reserved.
//
//

import Foundation
import CoreData


extension Exclusions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exclusions> {
        return NSFetchRequest<Exclusions>(entityName: "Exclusions")
    }

    @NSManaged public var facility_id: String?
    @NSManaged public var option_id: String?
    @NSManaged public var exclusionlist: ExclusionList?

}
