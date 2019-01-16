//
//  PostsViewController.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class PostsViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    var viewModel: PostsViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        registerCell()
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .interactive
        tableView.tableFooterView = UIView()
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = PostsViewModel.Input(trigger: Driver.merge(viewWillAppear, pull),
                                         selection: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
        
        output.posts.drive(tableView.rx.items(cellIdentifier: PostCell.reuseID, cellType: PostCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
        }
        .disposed(by: disposeBag)
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
    
        output.selectedPost
            .drive()
            .disposed(by: disposeBag)
    }

    private func registerCell() {
        tableView.register(UINib.init(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: PostCell.reuseID)
    }
}
