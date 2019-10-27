//
//  NewsFeedItem.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

struct NewsFeedItem {
    typealias Id = String

    var id: Id
    var date: Date
    
    var authorId: UserProfile.Id

    var text: String?
    var imageURL: URL?
    var isLiked: Bool
}
