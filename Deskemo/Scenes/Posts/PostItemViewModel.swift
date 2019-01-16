//
//  PostsItemViewModel.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain

final class PostItemViewModel {
    let title: String
    let subtitle: String
    let post: Post
    init(with post: Post) {
        self.post = post
        self.title = post.title.uppercased()
        self.subtitle = post.body
    }
}
