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
    private let imageManager: ImageManagerProtocol!
    
    init(navigator: SignUpNavigator, imageManager: ImageManagerProtocol) {
        self.navigator = navigator
        self.imageManager = imageManager
    }
    
    func transform(input: SignUpViewModel.Input) -> SignUpViewModel.Output {
        
        input.signUpTrigger.drive(onNext: { _ in
            self.navigator.toMainFlow()
        })
        .disposed(by: disposeBag)
        
        let imagePicked = pickImage(input.pickImageTrigger)
        
        return Output(imagePicked: imagePicked.asDriverOnErrorJustComplete())
    }
    
    private func pickImage(_ trigger: Driver<UITapGestureRecognizer>) -> Observable<UIImage> {
        let errorTracker = ErrorTracker()
        
        return trigger.asObservable()
            .flatMapLatest { _ in
                self.imageManager.pickImage(.photoLibrary)
                    .handleErrorContinue(errorTracker)
            }
            .share()
    }
}

extension SignUpViewModel {
    
    struct Input {
        let signUpTrigger: Driver<Void>
        let pickImageTrigger: Driver<UITapGestureRecognizer>
    }
    
    struct Output {
        let imagePicked: Driver<UIImage>
    }
}
