//
//  PostCell.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import AlamofireImage

final class PostCell: UITableViewCell {
    
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var lbUpdatedAt: UILabel!
    
    func bind(_ viewModel: PostItemViewModel) {
        if let url = URL.init(string: viewModel.post.imageUrl) {
            self.ivCover.af_setImage(withURL: url)
        }

        self.lbTitle.text = viewModel.title
        self.lbBody.text = viewModel.subtitle
        self.lbUpdatedAt.text = viewModel.post.updatedAt
    }
}
