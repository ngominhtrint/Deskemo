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
    
    init(storyboard: UIStoryboard, navigationController: UINavigationController) {
        self.storyboard = storyboard
        self.navigationController = navigationController
    }
    
    func toFavorites() {
        let favoritesViewController = storyboard.instantiateViewController(ofType: FavoritesViewController.self)
        navigationController.pushViewController(favoritesViewController, animated: true)
    }
    
    func toFavorite(post: Post) {
        
    }
}

