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
    
    private let activityIndicator = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    private let disposeBag = DisposeBag()
    
    private let useCase: PostsUseCase
    private let navigator: PostsNavigator
    private let posts = BehaviorRelay<[PostItemViewModel]>.init(value: [])
    
    init(useCase: PostsUseCase, navigator: PostsNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: PostsViewModel.Input) -> PostsViewModel.Output {
        
        let postsData = preloadPostsData()
        
        preloadPostsTask(trigger: input.preloadTrigger, datas: postsData)
        loadPostsTask(trigger: input.trigger)
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let selectedPost = input.selection
            .withLatestFrom(posts.asDriverOnErrorJustComplete()) { (indexPath, posts) -> Post in
                return posts[indexPath.row].post
            }
            .do(onNext: navigator.toPostDetail)
        
        return Output.init(posts: posts.asDriver(),
                           selectedPost: selectedPost,
                           fetching: fetching,
                           error: errors)
    }
    
    func favorite(_ post: Post, _ position: Int) {
        _ = Observable.just(post)
            .map { Post(post: $0, isFavorite: !$0.isFavorite) }
            .flatMapLatest { self.useCase.save(post: $0) }
            .flatMap { self.useCase.posts() }
            .map { $0.map { PostItemViewModel(with: $0) } }
            .subscribe(onNext: { newPosts in
                self.posts.accept(newPosts)
            })
            .disposed(by: disposeBag)
    }
    
    private func preloadPostsTask(trigger: Driver<Void>, datas: [Post]) {
        trigger.asObservable()
            .filter { SettingManager.shared.preloaded == false }
            .flatMapLatest {
                Observable.from(datas)
                    .flatMap { self.useCase.save(post: $0) }
                    .trackActivity(self.activityIndicator)
                    .trackError(self.errorTracker)
            }
            .subscribe(onNext: { _ in
                SettingManager.shared.preloaded = true
            })
            .disposed(by: disposeBag)
    }
    
    private func loadPostsTask(trigger: Driver<Void>) {
        trigger.asObservable()
            .flatMapLatest { _ in
                self.useCase.posts()
                    .trackActivity(self.activityIndicator)
                    .trackError(self.errorTracker)
            }
            .map { $0.map { PostItemViewModel.init(with: $0) } }
            .subscribe(onNext: { posts in
                self.posts.accept(posts)
            })
            .disposed(by: disposeBag)
    }
}

extension PostsViewModel {
    
    struct Input {
        let trigger: Driver<Void>
        let preloadTrigger: Driver<Void>
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
                         imageUrl: "https://via.placeholder.com/150/92c952",
                         isFavorite: false)
        
        let post2 = Post(body: "reprehenderit est deserunt velit ipsam",
                         title: "Reprehenderit",
                         imageUrl: "https://via.placeholder.com/600/771796",
                         isFavorite: false)
        
        let post3 = Post(body: "officia porro iure quia iusto qui ipsa ut modi",
                         title: "Officia",
                         imageUrl: "https://via.placeholder.com/600/24f355",
                         isFavorite: false)
        
        let post4 = Post(body: "culpa odio esse rerum omnis laboriosam voluptate repudiandae",
                         title: "Culpa",
                         imageUrl: "https://via.placeholder.com/600/d32776",
                         isFavorite: true)
        
        let post5 = Post(body: "natus nisi omnis corporis facere molestiae rerum in",
                         title: "Natus",
                         imageUrl: "https://via.placeholder.com/600/f66b97",
                         isFavorite: false)
        
        let post6 = Post(body: "aut porro officiis laborum odit ea laudantium corporis",
                         title: "Aut",
                         imageUrl: "https://via.placeholder.com/600/54176f",
                         isFavorite: false)
        
        let post7 = Post(body: "beatae et provident et ut vel",
                         title: "Beatae",
                         imageUrl: "https://via.placeholder.com/600/810b14",
                         isFavorite: true)
        
        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
        posts.append(post4)
        posts.append(post5)
        posts.append(post6)
        posts.append(post7)
        
        return posts
    }
}
