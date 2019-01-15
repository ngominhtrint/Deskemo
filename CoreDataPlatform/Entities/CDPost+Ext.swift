//
//  CDPost+Ext.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import CoreData
import Domain
import RxSwift
import QueryKit

extension CDPost {
    static var title: Attribute<String> { return Attribute("title") }
    static var uid: Attribute<String> { return Attribute("uid") }
    static var userId: Attribute<String> { return Attribute("userId") }
    static var body: Attribute<String> { return Attribute("body") }
    static var updatedAt: Attribute<String> { return Attribute("updatedAt") }
    static var isFavorite: Attribute<String> { return Attribute("isFavorite") }
    static var imageUrl: Attribute<String> { return Attribute("imageUrl") }
}

extension CDPost: DomainConvertibleType {
    func asDomain() -> Post {
        return Post.init(body: body!,
                         title: title!,
                         uid: uid!,
                         userId: userId!,
                         updatedAt: updatedAt!,
                         imageUrl: imageUrl!,
                         isFavorite: isFavorite)
    }
}

extension CDPost: Persistable {
    static var entityName: String {
        return "CDPost"
    }
}

extension Post: CoreDataRepresentable {
    
    typealias CoreDataType = CDPost
    
    func update(entity: CDPost) {
        entity.title = title
        entity.uid = uid
        entity.userId = userId
        entity.body = body
        entity.updatedAt = updatedAt
        entity.isFavorite = isFavorite
        entity.imageUrl = imageUrl
    }
}
