//
//  ArticleDetailsInteractorBuilder.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

/// Builder protocols usage prevents spreding of assembly logic in different layers.
/// Different builder-like protocols allows you to keep all class creation logic in assembly layer.
/// See NewsFeedPresenter.detailsInteractorBuilder to understand how it should work.
protocol ArticleDetailsInteractorBuilder {
    func articleDetailsInteractor(withArticleId articleId: NewsFeedArticleId) -> ArticleDetailsInteractorInterface
}
