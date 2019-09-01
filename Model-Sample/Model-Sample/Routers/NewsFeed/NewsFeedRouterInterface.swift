//
//  NewsFeedRouterInterface.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

protocol NewsFeedRouterInterface: RouterInterface {
    func showArticleDetails(with articleId: NewsFeedArticleId)
}
