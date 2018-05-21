//
//  ExclusionList+CoreDataProperties.swift
//  AgentDesks
//
//  Created by Mathew Wong on 5/21/18.
//  Copyright © 2018 yidgetsoft. All rights reserved.
//
//

import Foundation
import CoreData


extension ExclusionList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExclusionList> {
        return NSFetchRequest<ExclusionList>(entityName: "ExclusionList")
    }

    @NSManaged public var exclusion: String?
    @NSManaged public var exclusions: NSOrderedSet?

}

// MARK: Generated accessors for exclusions
extension ExclusionList {

    @objc(insertObject:inExclusionsAtIndex:)
    @NSManaged public func insertIntoExclusions(_ value: Exclusions, at idx: Int)

    @objc(removeObjectFromExclusionsAtIndex:)
    @NSManaged public func removeFromExclusions(at idx: Int)

    @objc(insertExclusions:atIndexes:)
    @NSManaged public func insertIntoExclusions(_ values: [Exclusions], at indexes: NSIndexSet)

    @objc(removeExclusionsAtIndexes:)
    @NSManaged public func removeFromExclusions(at indexes: NSIndexSet)

    @objc(replaceObjectInExclusionsAtIndex:withObject:)
    @NSManaged public func replaceExclusions(at idx: Int, with value: Exclusions)

    @objc(replaceExclusionsAtIndexes:withExclusions:)
    @NSManaged public func replaceExclusions(at indexes: NSIndexSet, with values: [Exclusions])

    @objc(addExclusionsObject:)
    @NSManaged public func addToExclusions(_ value: Exclusions)

    @objc(removeExclusionsObject:)
    @NSManaged public func removeFromExclusions(_ value: Exclusions)

    @objc(addExclusions:)
    @NSManaged public func addToExclusions(_ values: NSOrderedSet)

    @objc(removeExclusions:)
    @NSManaged public func removeFromExclusions(_ values: NSOrderedSet)

}
