//
//  ItemsViewModel.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class PostsViewModel: ViewModelType {
    
    private let useCase: PostsUseCase
    private let navigator: PostsNavigator
    
    init(useCase: PostsUseCase, navigator: PostsNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: PostsViewModel.Input) -> PostsViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let postsData = preloadPostsData()
        
        let posts = input.trigger.asObservable()
            .flatMapLatest {
                Observable.from(postsData)
                    .flatMap { self.useCase.save(post: $0) }
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
            }
            .flatMapLatest { _ in
                self.useCase.posts()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
            }
            .map { $0.map { PostItemViewModel.init(with: $0) } }
            .asDriverOnErrorJustComplete()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let selectedPost = input.selection
            .withLatestFrom(posts) { (indexPath, posts) -> Post in
                return posts[indexPath.row].post
            }
            .do(onNext: navigator.toPostDetail)
        
        return Output.init(posts: posts,
                           selectedPost: selectedPost,
                           fetching: fetching,
                           error: errors)
    }
}

extension PostsViewModel {
    
    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let posts: Driver<[PostItemViewModel]>
        let selectedPost: Driver<Post>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
}

extension PostsViewModel {
    
    private func preloadPostsData() -> [Post] {
        var posts = [Post]()
    
        let post1 = Post(body: "accusamus beatae ad facilis cum similique qui sunt",
                         title: "Accusamus",
                         imageUrl: "https://via.placeholder.com/150/92c952")
        
        let post2 = Post(body: "reprehenderit est deserunt velit ipsam",
                         title: "Reprehenderit",
                         imageUrl: "https://via.placeholder.com/600/771796")
        
        let post3 = Post(body: "officia porro iure quia iusto qui ipsa ut modi",
                         title: "Officia",
                         imageUrl: "https://via.placeholder.com/600/24f355")
        
        let post4 = Post(body: "culpa odio esse rerum omnis laboriosam voluptate repudiandae",
                         title: "Culpa",
                         imageUrl: "https://via.placeholder.com/600/d32776")
        
        let post5 = Post(body: "natus nisi omnis corporis facere molestiae rerum in",
                         title: "Natus",
                         imageUrl: "https://via.placeholder.com/600/f66b97")
        
        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
        posts.append(post4)
        posts.append(post5)
        
        return posts
    }
}
