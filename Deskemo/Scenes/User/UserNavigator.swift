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
    private let services: UseCaseProvider
    
    init(storyboard: UIStoryboard,
         navigationController: UINavigationController,
         services: UseCaseProvider) {
        self.storyboard = storyboard
        self.navigationController = navigationController
        self.services = services
    }
    
    func toProfile() {
        let userViewController = storyboard.instantiateViewController(ofType: UserViewController.self)
        userViewController.viewModel = UserViewModel(userUseCase: services.makeUserUseCase(), navigator: self)
        navigationController.pushViewController(userViewController, animated: true)
    }
}
