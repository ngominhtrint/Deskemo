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
    
    lazy var avatarTap = UITapGestureRecognizer()
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
        
        ivAvatar.contentMode = .scaleAspectFit
        ivAvatar.isUserInteractionEnabled = true
        ivAvatar.addGestureRecognizer(avatarTap)
    }
    
    private func bindViewModel() {
        assert(signUpViewModel != nil)
        
        let input = SignUpViewModel.Input(signUpTrigger: btnSignUp.rx.tap.asDriver(),
                                          pickImageTrigger: avatarTap.rx.event.asDriver())
        
        let output = signUpViewModel.transform(input: input)
        
        bindCoverImage(output.imagePicked)
        bindKeyboard()
    }
    
    private func bindCoverImage(_ image: Driver<UIImage>) {
        image.drive(onNext: { [weak self] image in
            guard let strongSelf = self else { return }
            strongSelf.ivAvatar.image = image
        })
        .disposed(by: disposeBag)
    }
    
    private func bindKeyboard() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { keyboardVisibleHeight in
                self.scrollView.contentInset.bottom = keyboardVisibleHeight
            })
            .disposed(by: disposeBag)
    }
}
