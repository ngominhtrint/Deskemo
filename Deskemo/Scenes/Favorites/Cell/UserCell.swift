//
//  UserCell.swift
//  Deskemo
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbBio: UILabel!

    func bind(_ viewModel: UserItemViewModel) {
        self.lbUsername.text = viewModel.username
        self.lbBio.text = viewModel.bio
    }
    
}
