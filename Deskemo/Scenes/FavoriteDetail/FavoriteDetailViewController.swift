//
//  FavoriteDetailViewController.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import RxKeyboard

class FavoriteDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvBody: UITextView!
    @IBOutlet weak var btnLogout: UIButton!
    
    let disposeBag = DisposeBag()
    var loginViewModel: LoginViewModel!
    var viewModel: FavoriteDetailViewModel!
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        self.navigationItem.title = "Favorite Detail"
        scrollView.keyboardDismissMode = .interactive
        
        tvBody.layer.cornerRadius = 6
        tvBody.layer.borderWidth = 1
        tvBody.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        
        btnLogout.layer.cornerRadius = 6
    }
    
    @IBAction func onLogoutClicked(_ sender: Any) {
        viewModel.logout()
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = FavoriteDetailViewModel.Input(trigger: viewWillAppear)
        
        let output = viewModel.transform(input: input)
        
        bindPost(output.post)
        bindKeyboard()
    }
    
    private func bindPost(_ post: Driver<Post>) {
        post.drive(onNext: { [weak self] post in
            guard let strongSelf = self else { return }
            
            strongSelf.post = post
            
            if let url = URL(string: post.imageUrl) {
                strongSelf.ivCover.af_setImage(withURL: url)
            }
            strongSelf.tfTitle.text = post.title.uppercased()
            strongSelf.tvBody.text = post.body
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
