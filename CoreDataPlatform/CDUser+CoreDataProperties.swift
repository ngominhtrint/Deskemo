//
//  CDUser+CoreDataProperties.swift
//  
//
//  Created by TriNgo on 1/15/19.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var uid: String?
    @NSManaged public var username: String?
    @NSManaged public var bio: String?
    @NSManaged public var avatar: String?

}
