//
//  DomainConvertibleType.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import QueryKit

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}

protocol CoreDataRepresentable {
    associatedtype CoreDataType: Persistable
    
    var uid: String { get }
    
    func update(entity: CoreDataType)
}

extension CoreDataRepresentable {
    func sync(in context: NSManagedObjectContext) -> Observable<CoreDataType> {
        return context.rx.sync(entity: self, update: update)
    }
}
