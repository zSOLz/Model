//
//  NewsFeedAssemblyInterface.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

protocol NewsFeedAssemblyInterface: AssemblyInterface {
    func newsFeedViewController() -> NewsFeedViewController
    func articleDetailsViewController(withArticleId articleId: NewsFeedArticleId) -> ArticleDetailsViewController
}
