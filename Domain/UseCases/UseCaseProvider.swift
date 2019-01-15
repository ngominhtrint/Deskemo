//
//  UseCaseProvider.swift
//  Domain
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    
    func makePostsUseCase() -> PostsUseCase
    func makeUserUseCase() -> UserUseCase
}
