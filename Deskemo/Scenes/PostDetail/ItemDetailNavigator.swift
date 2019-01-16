//
//  ItemDetailNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit

protocol ItemDetailNavigator {
    
    func toItems()
}

class DefaultItemDetailNavigator: ItemDetailNavigator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toItems() {
        navigationController.popViewController(animated: true)
    }
}
