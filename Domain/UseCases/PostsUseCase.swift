//
//  PostUseCase.swift
//  Domain
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import RxSwift

public protocol PostsUseCase {
    
    func posts() -> Observable<[Post]>
    func favoritePosts() -> Observable<[Post]>
    func save(post: Post) -> Observable<Void>
    func delete(post: Post) -> Observable<Void>
}
