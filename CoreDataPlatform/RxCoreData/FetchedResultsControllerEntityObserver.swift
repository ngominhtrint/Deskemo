//
//  FetchedResultsControllerEntityObserver.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

final class FetchedResultsControllerEntityObserver<T: NSFetchRequestResult>: NSObject, NSFetchedResultsControllerDelegate {
    
    typealias Observer = AnyObserver<[T]>
    
    fileprivate let observer: Observer
    fileprivate let disposeBag = DisposeBag()
    fileprivate let frc: NSFetchedResultsController<T>
    
    init(observer: Observer, fetchRequest: NSFetchRequest<T>, managedObjectContext context: NSManagedObjectContext, sectionNameKeyPath: String?, cacheName: String?) {
        self.observer = observer
        
        self.frc = NSFetchedResultsController.init(fetchRequest: fetchRequest,
                                                   managedObjectContext: context,
                                                   sectionNameKeyPath: sectionNameKeyPath,
                                                   cacheName: cacheName)
        super.init()
        
        context.perform {
            self.frc.delegate = self
            
            do {
                try self.frc.performFetch()
            } catch let e {
                observer.on(.error(e))
            }
            
            self.sendNextElement()
        }
    }
    
    fileprivate func sendNextElement() {
        self.frc.managedObjectContext.perform {
            let entities = self.frc.fetchedObjects ?? []
            self.observer.on(.next(entities))
        }
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        sendNextElement()
    }
}

extension FetchedResultsControllerEntityObserver: Disposable {
    
    public func dispose() {
        frc.delegate = nil
    }
}
