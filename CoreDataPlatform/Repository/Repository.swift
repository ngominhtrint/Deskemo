//
//  Repository.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import QueryKit

protocol AbstractRepository {
    
    associatedtype T
    func query(with predicate: NSPredicate?,
               sortDescriptors: [NSSortDescriptor]?) -> Observable<[T]>
    func save(entity: T) -> Observable<Void>
    func delete(entity: T) -> Observable<Void>
}

final class Repository<T: CoreDataRepresentable>: AbstractRepository where T == T.CoreDataType.DomainType {
    
    private let context: NSManagedObjectContext
    private let scheduler: ContextScheduler
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.scheduler = ContextScheduler(context: context)
    }
    
    func query(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Observable<[T]> {
        let request = T.CoreDataType.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return context.rx.entities(fetchRequest: request)
            .mapToDomain()
            .subscribeOn(scheduler)
    }
    
    func save(entity: T) -> Observable<Void> {
        return entity.sync(in: context)
            .mapToVoid()
            .flatMapLatest(context.rx.save)
            .subscribeOn(scheduler)
    }
    
    func delete(entity: T) -> Observable<Void> {
        return entity.sync(in: context)
            .map { $0 as! NSManagedObject }
            .flatMapLatest(context.rx.delete)
    }
}
