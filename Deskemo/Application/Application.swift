//
//  Application.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.mainNavigator
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain
import CoreDataPlatform

final class Application {
    static let shared = Application()
    
    private let coreDataUseCaseProvider: Domain.UseCaseProvider
    private let userUseCaseProvider: Domain.UseCaseProvider
    
    init() {
        self.coreDataUseCaseProvider = CoreDataPlatform.UseCaseProvider()
        self.userUseCaseProvider = CoreDataPlatform.UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
        // Login navigation
        let loginNavigationController = UINavigationController()
        let mainNavigator = DefaultMainNavigator(navigationController: loginNavigationController,
                                                 storyboard: storyboard)
        let loginNavigator = DefaultLoginNavigator(navigationController: loginNavigationController,
                                                   storyboard: storyboard,
                                                   mainNavigator: mainNavigator)
        
        window.rootViewController = loginNavigationController
        loginNavigator.toLogin()
    }
    
    
}

