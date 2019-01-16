//
//  MainNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit

protocol MainNavigator {
    
    func toMainFlow()
}

class DefaultMainNavigator: MainNavigator {
    
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController,
         storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.storyboard = storyboard
    }
    
    func toMainFlow() {
        // User Navigation
        let userNavigationController = UINavigationController()
        userNavigationController.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "ic_user"), selectedImage: nil)
        let userNavigator = DefaultUserNavigator(storyboard: storyboard, navigationController: userNavigationController)
        
        // Items Navigation
        let itemsNavigationController = UINavigationController()
        itemsNavigationController.tabBarItem = UITabBarItem(title: "Items", image: UIImage(named: "ic_post"), selectedImage: nil)
        let itemsNavigator = DefaultItemsNavigator(storyboard: storyboard, navigationController: itemsNavigationController)
        
        // Favorites Navigation
        let favoritesNavigationController = UINavigationController()
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "ic_star"), selectedImage: nil)
        let favoritesNavigator = DefaultFavoritesNavigator(storyboard: storyboard, navigationController: favoritesNavigationController)
        
        // Initiate tab bar controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [userNavigationController,
                                            itemsNavigationController,
                                            favoritesNavigationController]
        
        userNavigator.toProfile()
        itemsNavigator.toItems()
        favoritesNavigator.toFavorites()
        
        navigationController.present(tabBarController, animated: true, completion: nil)
    }
}
