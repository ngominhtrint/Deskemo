//
//  FavoriteItemViewModel.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain
import RxDataSources

enum FavoriteItemType: Int {
    case user
    case post
}

typealias FavoriteSection = SectionModel<FavoriteItemType, FavoriteItemViewModelProtocol>

let InitFavoriteSection: [FavoriteSection] = [
    SectionModel(model: .user, items: []),
    SectionModel(model: .post, items: [])
]

protocol FavoriteItemViewModelProtocol {}

struct UserItemViewModel: FavoriteItemViewModelProtocol {
    let username: String
    let bio: String
    
    init(with user: User) {
        self.username = user.username
        self.bio = user.bio
    }
}

struct FavoriteItemViewModel: FavoriteItemViewModelProtocol {
    let title: String
    let subtitle: String
    let post: Post
    
    init(with post: Post) {
        self.post = post
        self.title = post.title.uppercased()
        self.subtitle = post.body
    }
}

