//
//  FavoriteCell.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    
    func bind(_ viewModel: FavoriteItemViewModel) {
        self.lbTitle.text = viewModel.title
    }
}
