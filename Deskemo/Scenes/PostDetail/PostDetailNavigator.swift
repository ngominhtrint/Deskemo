//
//  PostDetailNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit

protocol PostDetailNavigator {
    
    func toPosts()
}

class DefaultPostDetailNavigator: PostDetailNavigator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toPosts() {
        navigationController.popViewController(animated: true)
    }
}
