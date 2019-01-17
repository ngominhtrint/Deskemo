//
//  UserViewController.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import AlamofireImage

class UserViewController: UIViewController {

    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbBio: UILabel!
    
    private let disposeBag = DisposeBag()
    var viewModel: UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        ivAvatar.layer.cornerRadius = ivAvatar.bounds.height / 2
        ivAvatar.clipsToBounds = true
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = UserViewModel.Input.init(trigger: viewWillAppear)
    
        let output = viewModel.transform(input: input)
        
        bindUser(user: output.user)
    }
    
    private func bindUser(user: Driver<User>) {
        user.drive(onNext: { [weak self] user in
            guard let strongSelf = self else { return }
            if let url = URL(string: user.avatar) {
                strongSelf.ivAvatar.af_setImage(withURL: url)
            }
            strongSelf.lbUsername.text = user.username
            strongSelf.lbBio.text = user.bio
        })
        .disposed(by: disposeBag)
    }
}
