//
//  SignUpViewModel.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    private let navigator: SignUpNavigator
    
    init(navigator: SignUpNavigator) {
        self.navigator = navigator
    }
    
    func transform(input: SignUpViewModel.Input) -> SignUpViewModel.Output {
        
        input.signUpTrigger.drive(onNext: { _ in
            self.navigator.toMainFlow()
        })
        .disposed(by: disposeBag)
        
        return Output()
    }
}

extension SignUpViewModel {
    
    struct Input {
        let signUpTrigger: Driver<Void>
    }
    
    struct Output {
        
    }
}
