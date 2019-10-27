//
//  FeedItenComment.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/27/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Foundation

struct FeedItemComment {
    typealias Id = String

    var id: Id
    var feedItemId: NewsFeedItem.Id
    var date: Date
    var authorId: UserProfile.Id
    var text: String
}
