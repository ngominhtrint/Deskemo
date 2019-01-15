//
//  PostsUseCase.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class PostsUseCase<Repository>: Domain.PostsUseCase where Repository: AbstractRepository, Repository.T == Post {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func posts() -> Observable<[Post]> {
        return repository.query(with: nil, sortDescriptors: [Post.CoreDataType.updatedAt.descending()])
    }
    
    func save(post: Post) -> Observable<Void> {
        return repository.save(entity: post)
    }
    
    func delete(post: Post) -> Observable<Void> {
        return repository.delete(entity: post)
    }
}
