//
//  Facilities+CoreDataProperties.swift
//  AgentDesks
//
//  Created by Mathew Wong on 5/21/18.
//  Copyright © 2018 yidgetsoft. All rights reserved.
//
//

import Foundation
import CoreData


extension Facilities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Facilities> {
        return NSFetchRequest<Facilities>(entityName: "Facilities")
    }

    @NSManaged public var facility_id: String?
    @NSManaged public var facility_name: String?
    @NSManaged public var options: NSOrderedSet?

}

// MARK: Generated accessors for options
extension Facilities {

    @objc(insertObject:inOptionsAtIndex:)
    @NSManaged public func insertIntoOptions(_ value: FacilityOptions, at idx: Int)

    @objc(removeObjectFromOptionsAtIndex:)
    @NSManaged public func removeFromOptions(at idx: Int)

    @objc(insertOptions:atIndexes:)
    @NSManaged public func insertIntoOptions(_ values: [FacilityOptions], at indexes: NSIndexSet)

    @objc(removeOptionsAtIndexes:)
    @NSManaged public func removeFromOptions(at indexes: NSIndexSet)

    @objc(replaceObjectInOptionsAtIndex:withObject:)
    @NSManaged public func replaceOptions(at idx: Int, with value: FacilityOptions)

    @objc(replaceOptionsAtIndexes:withOptions:)
    @NSManaged public func replaceOptions(at indexes: NSIndexSet, with values: [FacilityOptions])

    @objc(addOptionsObject:)
    @NSManaged public func addToOptions(_ value: FacilityOptions)

    @objc(removeOptionsObject:)
    @NSManaged public func removeFromOptions(_ value: FacilityOptions)

    @objc(addOptions:)
    @NSManaged public func addToOptions(_ values: NSOrderedSet)

    @objc(removeOptions:)
    @NSManaged public func removeFromOptions(_ values: NSOrderedSet)

}
