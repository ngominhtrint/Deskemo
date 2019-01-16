//
//  FavoritesViewController.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import RxDataSources

typealias FavoriteDataSource = RxTableViewSectionedReloadDataSource<FavoriteSection>

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: FavoritesViewModel!
    var dataSource: FavoriteDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = configDataSource()
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
        
        let input = FavoritesViewModel.Input(trigger: Driver.merge(viewWillAppear, pull),
                                         selection: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        bindFavorites(output.favoriteSections)
        
        output.selectedPost
            .drive()
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let weakSelf = self else { return }
                weakSelf.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindFavorites(_ sections: Driver<[FavoriteSection]>) {
        sections.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
    }
    
    private func configDataSource() -> FavoriteDataSource {
        
        return FavoriteDataSource(configureCell: { (dataSource, tv, indexPath, element) in
            if indexPath.section == 0 {
                guard let userCell = tv.dequeueReusableCell(withIdentifier: UserCell.reuseID, for: indexPath) as? UserCell, let user = element as? UserItemViewModel else {
                    return UITableViewCell()
                }
                userCell.bind(user)
                return userCell
            } else {
                guard let favoriteCell = tv.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as? FavoriteCell, let post = element as? FavoriteItemViewModel else {
                    return UITableViewCell()
                }
                favoriteCell.bind(post)
                return favoriteCell
            }
        })
    }
    
    private func registerCell() {
        tableView.register(UINib.init(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: UserCell.reuseID)
        tableView.register(UINib.init(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: FavoriteCell.reuseID)
    }
}
