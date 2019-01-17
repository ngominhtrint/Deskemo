//
//  ItemDetailViewModel.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class PostDetailViewModel: ViewModelType {
    
    private let activityIndicator = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    private let disposeBag = DisposeBag()
    
    private let useCase: PostsUseCase
    private let navigator: PostDetailNavigator
    private let post = BehaviorRelay<Post>(value: Post(body: "", title: "", imageUrl: "", isFavorite: false))
    
    init(useCase: PostsUseCase, navigator: PostDetailNavigator, post: Post) {
        self.useCase = useCase
        self.navigator = navigator
        self.post.accept(post)
    }
    
    func transform(input: PostDetailViewModel.Input) -> PostDetailViewModel.Output {
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output.init(post: post.asDriver(),
                           fetching: fetching,
                           error: errors)
    }
    
    func update(_ post: Post) {
        _ = Observable.just(post)
            .do(onNext: { post in
                print(post)
            })
            .flatMapLatest { self.useCase.save(post: $0) }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.navigator.toPosts()
            })
            .disposed(by: disposeBag)
    }
}

extension PostDetailViewModel {
    
    struct Input {
        let trigger: Driver<Void>
        let saveTrigger: Driver<Void>
    }
    
    struct Output {
        let post: Driver<Post>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
}
