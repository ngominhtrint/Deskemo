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
    private let userUseCase: UserUseCase
    private let navigator: PostsNavigator
    
    init(postUseCase: PostsUseCase, userUseCase: UserUseCase, navigator: PostsNavigator) {
        self.postUseCase = postUseCase
        self.userUseCase = userUseCase
        self.navigator = navigator
    }
    
    func transform(input: FavoriteDetailViewModel.Input) -> FavoriteDetailViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(fetching: fetching,
                      error: errors)
    }
}

extension FavoriteDetailViewModel {
    
    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
}


