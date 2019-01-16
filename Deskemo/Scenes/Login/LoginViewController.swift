//
//  LoginViewController.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        assert(loginViewModel != nil)
        
        let input = LoginViewModel.Input(loginTrigger: btnLogin.rx.tap.asDriver(),
                                         signUpTrigger: btnSignUp.rx.tap.asDriver())
        
        let _ = loginViewModel.transform(input: input)
    }
}

