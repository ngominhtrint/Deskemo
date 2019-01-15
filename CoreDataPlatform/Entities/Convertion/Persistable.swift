//
//  Persistable.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import QueryKit

protocol Persistable: NSFetchRequestResult, DomainConvertibleType {
    
    static var entityName: String { get }
    static func fetchRequest() -> NSFetchRequest<Self>
}

extension Persistable {
    static var primaryAttribute: Attribute<String> {
        return Attribute("uid")
    }
}
