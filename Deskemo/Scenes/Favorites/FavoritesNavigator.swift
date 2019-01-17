//
//  FavoritesNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain

protocol FavoritesNavigator {
    
    func toFavorites()
    func toFavorite(post: Post)
}

class DefaultFavoritesNavigator: FavoritesNavigator {
    
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
    
    func toFavorites() {
        let favoritesViewController = storyboard.instantiateViewController(ofType: FavoritesViewController.self)
        favoritesViewController.viewModel = FavoritesViewModel(postUseCase: services.makePostsUseCase(),
                                                               userUseCase: services.makeUserUseCase(),
                                                               navigator: self)
        navigationController.pushViewController(favoritesViewController, animated: true)
    }
    
    func toFavorite(post: Post) {
        let favoriteDetailNavigator = DefaultFavoriteDetailNavigator(navigationController: navigationController)
        let favoriteDetailViewController = storyboard.instantiateViewController(ofType: FavoriteDetailViewController.self)
        favoriteDetailViewController.viewModel = FavoriteDetailViewModel(postUseCase: services.makePostsUseCase(),
                                                                         navigator: favoriteDetailNavigator,
                                                                         post: post)
        navigationController.pushViewController(favoriteDetailViewController, animated: true)
    }
}
