//
//  UserList+CoreDataProperties.swift
//  AgentDesks
//
//  Created by Mathew Wong on 5/21/18.
//  Copyright © 2018 yidgetsoft. All rights reserved.
//
//

import Foundation
import CoreData


extension UserList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserList> {
        return NSFetchRequest<UserList>(entityName: "UserList")
    }

    @NSManaged public var facility_id: String?
    @NSManaged public var option_id: String?

}
