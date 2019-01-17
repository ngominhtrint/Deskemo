//
//  MainNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import Domain
import CoreDataPlatform

protocol MainNavigator {
    
    func toMainFlow()
}

class DefaultMainNavigator: MainNavigator {
    
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    private let coreDataUseCaseProvider: Domain.UseCaseProvider
    
    init(navigationController: UINavigationController,
         storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.storyboard = storyboard
        self.coreDataUseCaseProvider = CoreDataPlatform.UseCaseProvider()
    }
    
    func toMainFlow() {
        // User Navigation
        let userNavigationController = UINavigationController()
        userNavigationController.tabBarItem = UITabBarItem(title: "User",
                                                           image: UIImage(named: "ic_user"),
                                                           selectedImage: nil)
        let userNavigator = DefaultUserNavigator(storyboard: storyboard,
                                                 navigationController: userNavigationController,
                                                 services: coreDataUseCaseProvider)
        
        // Items Navigation
        let itemsNavigationController = UINavigationController()
        itemsNavigationController.tabBarItem = UITabBarItem(title: "Items",
                                                            image: UIImage(named: "ic_post"),
                                                            selectedImage: nil)
        let postsNavigator = DefaultPostsNavigator(storyboard: storyboard,
                                                   navigationController: itemsNavigationController,
                                                   services: coreDataUseCaseProvider)
        
        // Favorites Navigation
        let favoritesNavigationController = UINavigationController()
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites",
                                                                image: UIImage(named: "ic_star"),
                                                                selectedImage: nil)
        let favoritesNavigator = DefaultFavoritesNavigator(storyboard: storyboard,
                                                           navigationController: favoritesNavigationController,
                                                           services: coreDataUseCaseProvider)
        
        // Initiate tab bar controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [userNavigationController,
                                            itemsNavigationController,
                                            favoritesNavigationController]
        
        // select Items as default
        tabBarController.selectedIndex = 1
        
        userNavigator.toProfile()
        postsNavigator.toPosts()
        favoritesNavigator.toFavorites()
        
        navigationController.present(tabBarController, animated: true, completion: nil)
    }
}
