//
//  CoreDataStack.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    private let storeCoordinator: NSPersistentStoreCoordinator
    let context: NSManagedObjectContext
    
    public init() {
        let bundle = Bundle(for: CoreDataStack.self)
        guard let url = bundle.url(forResource: "Model", withExtension: "momd"), let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError()
        }
        self.storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        self.context = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        self.context.persistentStoreCoordinator = self.storeCoordinator
        self.migrateStore()
    }
    
    private func migrateStore() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError()
        }
        let storeUrl = url.appendingPathComponent("Model.sqlite")
        do {
            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
}
