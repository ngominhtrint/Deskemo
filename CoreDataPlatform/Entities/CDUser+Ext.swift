//
//  CDUser+Ext.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import CoreData
import Domain
import RxSwift
import QueryKit

extension CDUser {
    
    static var uid: Attribute<String> { return Attribute("uid") }
    static var username: Attribute<String> { return Attribute("username") }
    static var bio: Attribute<String> { return Attribute("bio") }
    static var avatar: Attribute<String> { return Attribute("avatar") }
}

extension CDUser: DomainConvertibleType {
    
    func asDomain() -> User {
        return User.init(uid: uid!,
                         username: username!,
                         avatar: avatar!,
                         bio: bio!)
    }
}

extension CDUser: Persistable {
    static var entityName: String {
        return "CDUser"
    }
}

extension User: CoreDataRepresentable {
    
    typealias CoreDataType = CDUser
    
    func update(entity: CDUser) {
        entity.uid = uid
        entity.username = username
        entity.bio = bio
        entity.avatar = avatar
    }
}
