//
//  FeedItemCommentTableViewCell.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/27/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

struct FeedItemCommentViewModel {
    let authorId: UserProfile.Id
    let authorAvatarURL: URL?
    let authorName: String
    let date: String
    let text: String
}

final class FeedItemCommentTableViewCell: UITableViewCell {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var authorButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    var tapUserNameClosure: () -> Void = {}

    func setup(viewModel: FeedItemCommentViewModel) {
        avatarImageView.loadImage(url: viewModel.authorAvatarURL)
        contentTextView.text = viewModel.text
        authorButton.setTitle(viewModel.authorName, for: .normal)
        dateLabel.text = viewModel.date
        avatarImageView.roundCornersWithMaximumRadius()
    }
    
    @IBAction func didTapUserName(_ sender: Any) {
        tapUserNameClosure()
    }
}
