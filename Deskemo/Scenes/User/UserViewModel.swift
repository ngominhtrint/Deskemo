//
//  UserViewModel.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa
import RxDataSources

final class UserViewModel: ViewModelType {

    private let userUseCase: UserUseCase
    private let navigator: UserNavigator
    
    init(userUseCase: UserUseCase, navigator: UserNavigator) {
        self.userUseCase = userUseCase
        self.navigator = navigator
    }
    
    func transform(input: UserViewModel.Input) -> UserViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let userPreload = preloadPostsData()
        
        let user = input.trigger.asObservable()
            .flatMapLatest { self.userUseCase.create(user: userPreload) }
            .flatMapLatest {
                self.userUseCase.user(username: "rover")
                    .trackActivity(activityIndicator)
                    .handleErrorContinue(errorTracker)
            }
            .filter { $0.count > 0 }
            .map { $0.first! }
            .asDriverOnErrorJustComplete()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(user: user,
                      fetching: fetching,
                      error: errors)
    }
}

extension UserViewModel {
    
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let user: Driver<User>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
}

extension UserViewModel {
    
    private func preloadPostsData() -> User {
        return User.init(uid: "1", username: "rover", avatar: "https://i.imgur.com/3UIj6MW.png", bio: "Einstein always excelled at math and physics from a young age, reaching a mathematical level years ahead of his peers. The twelve year old Einstein taught himself algebra and Euclidean geometry over a single summer. Einstein also independently discovered his own original proof of the Pythagorean theorem at age 12.")
    }
}
