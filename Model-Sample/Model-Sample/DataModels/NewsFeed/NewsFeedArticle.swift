//
//  NewsFeedArticle.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

typealias NewsFeedArticleId = String

struct NewsFeedArticle {
    let articleId: NewsFeedArticleId
    let title: String
    let authorName: String
    let imageName: String?
    let text: String
}
