//
//  LoginViewModel.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    private let navigator: LoginNavigator
    
    init(navigator: LoginNavigator) {
        self.navigator = navigator
    }
    
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        
        input.loginTrigger.drive(onNext: { _ in
            self.navigator.toMainFlow()
        })
        .disposed(by: disposeBag)
        
        input.signUpTrigger.drive(onNext: { _ in
            self.navigator.toSignUp()
        })
        .disposed(by: disposeBag)
        
        return Output.init()
    }
}

extension LoginViewModel {
    
    struct Input {
        let loginTrigger: Driver<Void>
        let signUpTrigger: Driver<Void>
    }
    
    struct Output {
        
    }
}
