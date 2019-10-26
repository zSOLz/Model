//
//  ArticleDetailsViewController.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

final class ArticleDetailsViewController: ViewController {
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var coverImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
}

//// MARK: - ArticleDetailsViewInterface
//extension ArticleDetailsViewController: ArticleDetailsViewInterface {
//    internal func setup(viewModel: ArticleDetailsViewModel) {
//        if let coverImage = viewModel.image {
//            coverImageView.image = coverImage
//            coverImageHeightConstraint.constant = 140
//        } else {
//            coverImageView.image = nil
//            coverImageHeightConstraint.constant = 0
//        }
//        titleLabel.text = viewModel.title
//        authorLabel.text = viewModel.author
//        textLabel.text = viewModel.text
//    }
//}
