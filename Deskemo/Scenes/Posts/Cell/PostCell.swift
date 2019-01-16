//
//  PostCell.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit

final class PostCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    
    func bind(_ viewModel: PostItemViewModel) {
        self.lbTitle.text = viewModel.title
        self.lbBody.text = viewModel.subtitle
    }
}
