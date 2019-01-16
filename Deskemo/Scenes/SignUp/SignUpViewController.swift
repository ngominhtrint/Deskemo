//
//  SignUpViewController.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var btnSignUp: UIButton!
    
    var signUpViewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        assert(signUpViewModel != nil)
        
        let input = SignUpViewModel.Input(signUpTrigger: btnSignUp.rx.tap.asDriver())
        
        let _ = signUpViewModel.transform(input: input)
    }
}
