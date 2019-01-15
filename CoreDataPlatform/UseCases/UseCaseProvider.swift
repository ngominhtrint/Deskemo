//
//  UseCaseProvider.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    private let coreDataStack = CoreDataStack()
    private let postRepository: Repository<Post>
    private let userRepository: Repository<User>
    
    public init() {
        postRepository = Repository<Post>(context: coreDataStack.context)
        userRepository = Repository<User>(context: coreDataStack.context)
    }
    
    public func makePostsUseCase() -> Domain.PostsUseCase {
        return PostsUseCase.init(repository: postRepository)
    }
    
    public func makeUserUseCase() -> Domain.UserUseCase {
        return UserUseCase.init(repository: userRepository)
    }
}
