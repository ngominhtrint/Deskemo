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
import RxKeyboard

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var tvBio: UITextView!
    
    var signUpViewModel: SignUpViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        self.navigationItem.title = "SignUp"
        scrollView.keyboardDismissMode = .interactive

        btnSignUp.layer.cornerRadius = 6
        btnSignUp.layer.borderWidth = 2
        btnSignUp.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).cgColor
        
        tvBio.layer.cornerRadius = 6
        tvBio.layer.borderWidth = 1
        tvBio.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
    }
    
    private func bindViewModel() {
        assert(signUpViewModel != nil)
        
        let input = SignUpViewModel.Input(signUpTrigger: btnSignUp.rx.tap.asDriver())
        
        let _ = signUpViewModel.transform(input: input)
        
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
