//
//  NewsFeedDataSession.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class NewsFeedCache {
    var feedItems: [NewsFeedItem.Id: NewsFeedItem] = [:]
    var feedItemComments: [NewsFeedItem.Id: [FeedItemComment]] = [:]
}
