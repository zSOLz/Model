//
//  NewsFeedTableCell.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

final class NewsFeedTableCell: UITableViewCell {
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var coverImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    func setup(viewModel: NewsFeedArticleViewModel) {
        if let coverImage = viewModel.image {
            coverImageView.image = coverImage
            coverImageHeightConstraint.constant = 100
        } else {
            coverImageView.image = nil
            coverImageHeightConstraint.constant = 0
        }
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
    }
}
