//
//  FavoriteDetailNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit

protocol FavoriteDetailNavigator {
    
    func toFavorites()
}

class DefaultFavoriteDetailNavigator: FavoriteDetailNavigator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toFavorites() {
        navigationController.popViewController(animated: true)
    }
}
