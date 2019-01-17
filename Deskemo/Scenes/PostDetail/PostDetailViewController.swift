//
//  PostDetailViewController.swift
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

class PostDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvBody: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    
    let disposeBag = DisposeBag()
    var loginViewModel: LoginViewModel!
    var viewModel: PostDetailViewModel!
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        self.navigationItem.title = "Post Detail"
        scrollView.keyboardDismissMode = .interactive
        
        btnSave.isEnabled = true
        btnSave.layer.cornerRadius = 6
        
        tvBody.layer.cornerRadius = 6
        tvBody.layer.borderWidth = 1
        tvBody.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        let title = self.tfTitle.text ?? ""
        let body = self.tvBody.text ?? ""
        let newPost = Post(body: body,
                           title: title,
                           uid: self.post.uid,
                           userId: self.post.userId,
                           updatedAt: String(round(Date().timeIntervalSince1970 * 1000)),
                           imageUrl: self.post.imageUrl,
                           isFavorite: self.post.isFavorite)
        self.viewModel.update(newPost)
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let saveTrigger = btnSave.rx.tap.asDriver()
            .debounce(0.6)
        
        let input = PostDetailViewModel.Input(trigger: viewWillAppear,
                                               saveTrigger: saveTrigger)
        
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
