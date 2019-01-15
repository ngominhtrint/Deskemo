//
//  Post.swift
//  Domain
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation

public struct Post: Codable {
    public let body: String
    public let title: String
    public let uid: String
    public let userId: String
    public let updatedAt: String
    public let imageUrl: String
    public let isFavorite: Bool
    
    public init(body: String,
                title: String,
                uid: String,
                userId: String,
                updatedAt: String,
                imageUrl: String,
                isFavorite: Bool) {
        self.body = body
        self.title = title
        self.uid = uid
        self.userId = userId
        self.updatedAt = updatedAt
        self.imageUrl = imageUrl
        self.isFavorite = isFavorite
    }
    
    public init(body: String, title: String, imageUrl: String) {
        self.init(body: body, title: title, uid: NSUUID().uuidString, userId: "5", updatedAt: String(round(Date().timeIntervalSince1970 * 1000)), imageUrl: imageUrl, isFavorite: false)
    }
    
    private enum CodingKeys: String, CodingKey {
        case body
        case title
        case uid
        case userId
        case updatedAt
        case imageUrl
        case isFavorite
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        body = try container.decode(String.self, forKey: .body)
        title = try container.decode(String.self, forKey: .title)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        
        if let uid = try container.decodeIfPresent(Int.self, forKey: .uid) {
            self.uid = "\(uid)"
        } else {
            uid = try container.decodeIfPresent(String.self, forKey: .uid) ?? ""
        }
        
        if let userId = try container.decodeIfPresent(Int.self, forKey: .userId) {
            self.userId = "\(userId)"
        } else {
            userId = try container.decodeIfPresent(String.self, forKey: .userId) ?? ""
        }
        
        if let updatedAt = try container.decodeIfPresent(Int.self, forKey: .updatedAt) {
            self.updatedAt = "\(updatedAt)"
        } else {
            updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
        }
    }
}

extension Post: Equatable {
    public static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.uid == rhs.uid &&
            lhs.title == rhs.title &&
            lhs.body == rhs.body &&
            lhs.userId == rhs.userId &&
            lhs.imageUrl == rhs.imageUrl &&
            lhs.isFavorite == rhs.isFavorite &&
            lhs.updatedAt == rhs.updatedAt
    }
}
