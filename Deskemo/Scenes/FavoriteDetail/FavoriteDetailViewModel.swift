//
//  FavoriteDetailViewModel.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class FavoriteDetailViewModel: ViewModelType {
    
    private let postUseCase: PostsUseCase
    private let navigator: FavoriteDetailNavigator
    
    private let post = BehaviorRelay<Post>(value: Post(body: "", title: "", imageUrl: "", isFavorite: false))
    
    init(postUseCase: PostsUseCase, navigator: FavoriteDetailNavigator, post: Post) {
        self.postUseCase = postUseCase
        self.navigator = navigator
        self.post.accept(post)
    }
    
    func transform(input: FavoriteDetailViewModel.Input) -> FavoriteDetailViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(post: post.asDriver(),
                      fetching: fetching,
                      error: errors)
    }
}

extension FavoriteDetailViewModel {
    
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let post: Driver<Post>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
}


