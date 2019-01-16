//
//  PostsNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import Domain

protocol PostsNavigator {
    
    func toPosts()
    func toPostDetail(post: Post)
}

class DefaultPostsNavigator: PostsNavigator {
    
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    
    init(storyboard: UIStoryboard,
         navigationController: UINavigationController,
         services: UseCaseProvider) {
        self.storyboard = storyboard
        self.navigationController = navigationController
        self.services = services
    }
    
    func toPosts() {
        let postsViewController = storyboard.instantiateViewController(ofType: PostsViewController.self)
        postsViewController.viewModel = PostsViewModel(useCase: services.makePostsUseCase(), navigator: self)
        navigationController.pushViewController(postsViewController, animated: true)
    }
    
    func toPostDetail(post: Post) {
        
    }
}
