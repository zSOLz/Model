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
        if let url = viewModel.authorAvatarURL {
            avatarImageView.image = UIImage(contentsOfFile: url.path)
        } else {
            avatarImageView.image = nil
        }
        if let contentImageURL = viewModel.imageURL {
            contentImageView.image = UIImage(contentsOfFile: contentImageURL.path)
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
