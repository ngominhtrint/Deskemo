//
//  User.swift
//  Domain
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation

public struct User: Codable {
    
    public let uid: String
    public let username: String
    public let avatar: String
    public let bio: String
    
    public init(uid: String,
                username: String,
                avatar: String,
                bio: String) {
        self.uid = uid
        self.username = username
        self.avatar = avatar
        self.bio = bio
    }
    
    private enum CodingKeys: String, CodingKey {
        case uid
        case username
        case avatar
        case bio
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        username = try container.decode(String.self, forKey: .username)
        avatar = try container.decode(String.self, forKey: .avatar)
        bio = try container.decode(String.self, forKey: .bio)
        
        if let uid = try container.decodeIfPresent(Int.self, forKey: .uid) {
            self.uid = "\(uid)"
        } else {
            uid = try container.decodeIfPresent(String.self, forKey: .uid) ?? ""
        }
    }
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid &&
            lhs.username == rhs.username &&
            lhs.avatar == rhs.avatar &&
            lhs.bio == rhs.bio
    }
}
