//
//  FavoritesViewModel.swift
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

final class FavoritesViewModel: ViewModelType {
    
    private let postUseCase: PostsUseCase
    private let userUseCase: UserUseCase
    private let navigator: FavoritesNavigator
    
    init(postUseCase: PostsUseCase, userUseCase: UserUseCase, navigator: FavoritesNavigator) {
        self.postUseCase = postUseCase
        self.userUseCase = userUseCase
        self.navigator = navigator
    }
    
    func transform(input: FavoritesViewModel.Input) -> FavoritesViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let user = preloadPostsData()
        
        let users = input.trigger.asObservable()
            .flatMapLatest { self.userUseCase.create(user: user) }
            .flatMapLatest {
                self.userUseCase.user(username: "rover")
                    .trackActivity(activityIndicator)
                    .handleErrorContinue(errorTracker)
            }
            .map { $0.map { UserItemViewModel.init(with: $0) } }
        
        let posts = input.trigger.asObservable()
            .flatMapLatest {
                self.postUseCase.favoritePosts()
                    .trackActivity(activityIndicator)
                    .handleErrorContinue(errorTracker)
            }
            .map { $0.map { FavoriteItemViewModel.init(with: $0) } }
        
        let favoriteSections = Observable.combineLatest(users, posts) {
                self.toSection(user: $0, post: $1)
            }
            .asDriver(onErrorJustReturn: [])
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let selectedPost = input.selection
            .filter { $0.section != 0 }
            .withLatestFrom(posts.asDriverOnErrorJustComplete()) { (indexPath, posts) -> Post in
                return posts[indexPath.row].post
            }
            .do(onNext: navigator.toFavorite)
        
        return Output(favoriteSections: favoriteSections,
                      selectedPost: selectedPost,
                      fetching: fetching,
                      error: errors)
    }
    
    private func toSection(user: [UserItemViewModel], post: [FavoriteItemViewModel]) -> [FavoriteSection] {
        return [
            SectionModel(model: .user, items: user),
            SectionModel(model: .post, items: post)
        ]
    }
}

extension FavoritesViewModel {
    
    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let favoriteSections: Driver<[FavoriteSection]>
        let selectedPost: Driver<Post>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
}

extension FavoritesViewModel {
    
    private func preloadPostsData() -> User {
        return User(uid: "1", username: "rover", avatar: "https://i.imgur.com/3UIj6MW.png", bio: "Einstein always excelled at math and physics from a young age, reaching a mathematical level years ahead of his peers. The twelve year old Einstein taught himself algebra and Euclidean geometry over a single summer. Einstein also independently discovered his own original proof of the Pythagorean theorem at age 12.")
    }
}
