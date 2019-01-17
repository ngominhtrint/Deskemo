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
import RxKeyboard

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    let disposeBag = DisposeBag()
    var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        self.navigationItem.title = "Login"
        scrollView.keyboardDismissMode = .interactive
        
        btnLogin.layer.cornerRadius = 6
        btnSignUp.layer.cornerRadius = 6
        btnSignUp.layer.borderWidth = 2
        btnSignUp.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).cgColor
    }
    
    private func bindViewModel() {
        assert(loginViewModel != nil)
        
        let input = LoginViewModel.Input(loginTrigger: btnLogin.rx.tap.asDriver(),
                                         signUpTrigger: btnSignUp.rx.tap.asDriver())
        
        let _ = loginViewModel.transform(input: input)
        
        bindKeyboard()
    }
    
    private func bindKeyboard() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { keyboardVisibleHeight in
                self.scrollView.contentInset.bottom = keyboardVisibleHeight
            })
            .disposed(by: disposeBag)
    }
}

