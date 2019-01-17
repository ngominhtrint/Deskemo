//
//  PostCell.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import Domain
import AlamofireImage

protocol PostCellDelegate: class {
    
    func didClickFavorite(_ post: Post, _ position: Int)
}

final class PostCell: UITableViewCell {
    
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var lbUpdatedAt: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    weak var delegate: PostCellDelegate!
    var position: Int!
    var post: Post!
    
    func bind(_ viewModel: PostItemViewModel) {
        post = viewModel.post
        
        if let url = URL.init(string: viewModel.post.imageUrl) {
            self.ivCover.af_setImage(withURL: url)
        }

        self.lbTitle.text = viewModel.title
        self.lbBody.text = viewModel.subtitle
        self.lbUpdatedAt.text = viewModel.post.updatedAt
        self.btnFavorite.setImage(viewModel.post.isFavorite ?
            UIImage(named: "ic_star_selected") : UIImage(named: "ic_star_unselected"), for: .normal)
    }
    
    @IBAction func onFavoriteClicked(_ sender: Any) {
        delegate.didClickFavorite(post, position)
    }
}
