//
//  UserNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain

protocol UserNavigator {
    
    func toProfile()
}

class DefaultUserNavigator: UserNavigator {
    
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(storyboard: UIStoryboard, navigationController: UINavigationController) {
        self.storyboard = storyboard
        self.navigationController = navigationController
    }
    
    func toProfile() {
        let userViewController = storyboard.instantiateViewController(ofType: UserViewController.self)
        navigationController.pushViewController(userViewController, animated: true)
    }
}
