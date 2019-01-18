//
//  LoginNavigator.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import Domain

protocol LoginNavigator {
 
    func toLogin()
    func toSignUp()
    func toMainFlow()
}

class DefaultLoginNavigator: LoginNavigator {
    
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    private let mainNavigator: DefaultMainNavigator
    
    init(navigationController: UINavigationController,
         storyboard: UIStoryboard,
         mainNavigator: DefaultMainNavigator) {
        self.navigationController = navigationController
        self.storyboard = storyboard
        self.mainNavigator = mainNavigator
    }
    
    func toLogin() {
        let loginViewController = storyboard.instantiateViewController(ofType: LoginViewController.self)
        loginViewController.loginViewModel = LoginViewModel(navigator: self)
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func toSignUp() {
        let imageManager = ImageManager(viewController: navigationController)
        let signUpNavigator = DefaultSignUpNavigator(storyboard: storyboard,
                                                     navigationController: navigationController,
                                                     mainNavigator: mainNavigator)
        let signUpViewController = storyboard.instantiateViewController(ofType: SignUpViewController.self)
        signUpViewController.signUpViewModel = SignUpViewModel(navigator: signUpNavigator, imageManager: imageManager)
        navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func toMainFlow() {
        mainNavigator.toMainFlow()
    }
}
