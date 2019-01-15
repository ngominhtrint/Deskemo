//
//  Observable+Ext.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

extension Observable where Element: Sequence, Element.Iterator.Element: DomainConvertibleType {
    typealias DomainType = Element.Iterator.Element.DomainType
    
    func mapToDomain() -> Observable<[DomainType]> {
        return map { sequence -> [DomainType] in
            return sequence.mapToDomain()
        }
    }
}

extension Sequence where Iterator.Element: DomainConvertibleType {
    typealias Element = Iterator.Element
    func mapToDomain() -> [Element.DomainType] {
        return map {
            return $0.asDomain()
        }
    }
}
