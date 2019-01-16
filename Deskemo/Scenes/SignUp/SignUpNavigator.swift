//
//  SignUpNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit

protocol SignUpNavigator {
    
    func toMainFlow()
}

class DefaultSignUpNavigator: SignUpNavigator {
    
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    private let mainNavigator: DefaultMainNavigator
    
    init(storyboard: UIStoryboard,
         navigationController: UINavigationController,
         mainNavigator: DefaultMainNavigator) {
        self.storyboard = storyboard
        self.navigationController = navigationController
        self.mainNavigator = mainNavigator
    }
    
    func toMainFlow() {
        mainNavigator.toMainFlow()
    }
}
