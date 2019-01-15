//
//  NSManagedObjectContext+Ext.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func create<T: NSFetchRequestResult>() -> T {
        guard let entity = NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self), into: self) as? T else {
            fatalError()
        }
        return entity
    }
}
