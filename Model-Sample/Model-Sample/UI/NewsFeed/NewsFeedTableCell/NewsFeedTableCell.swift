//
//  NewsFeedTableCell.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

struct NewsFeedItemViewModel {
    let itemId: NewsFeedItem.Id
    let authorId: UserProfile.Id
    let authorAvatarURL: URL?
    let authorName: String
    let date: String
    let text: String?
    let imageURL: URL?
}

final class NewsFeedTableCell: UITableViewCell {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var authorButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    var tapUserNameClosure: () -> Void = {}

    func setup(viewModel: NewsFeedItemViewModel) {
        avatarImageView.loadImage(url: viewModel.authorAvatarURL)
        contentImageView.loadImage(url: viewModel.imageURL)
        if viewModel.imageURL != nil {
            contentImageView.isHidden = false
        } else {
            contentImageView.isHidden = true
        }
        if let text = viewModel.text {
            contentTextView.text = text
            contentTextView.isHidden = false
        } else {
            contentTextView.isHidden = true
        }
        authorButton.setTitle(viewModel.authorName, for: .normal)
        dateLabel.text = viewModel.date
        avatarImageView.roundCornersWithMaximumRadius()
    }
    
    @IBAction func didTapUserName(_ sender: Any) {
        tapUserNameClosure()
    }
}
