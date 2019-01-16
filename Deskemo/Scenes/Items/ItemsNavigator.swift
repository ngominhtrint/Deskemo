//
//  ItemsNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import Domain

protocol ItemsNavigator {
    
    func toItems()
    func toItemDetail(post: Post)
}

class DefaultItemsNavigator: ItemsNavigator {
    
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(storyboard: UIStoryboard, navigationController: UINavigationController) {
        self.storyboard = storyboard
        self.navigationController = navigationController
    }
    
    func toItems() {
        let itemsViewController = storyboard.instantiateViewController(ofType: ItemsViewController.self)
        navigationController.pushViewController(itemsViewController, animated: true)
    }
    
    func toItemDetail(post: Post) {
        
    }
}
