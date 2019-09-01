//
//  ArticleDetailsInteractor.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class ArticleDetailsInteractor: Interactor {
    fileprivate var article: NewsFeedArticle
    
    init(newsFeedDataSession: NewsFeedDataSession, articleId: NewsFeedArticleId) {
        guard let articleFromSession = newsFeedDataSession.article(withId: articleId) else {
            fatalError("Article not found with id: \(articleId)")
        }
        article = articleFromSession
    }
    
    init(article: NewsFeedArticle) {
        self.article = article
    }
}

// MARK: - ArticleDetailsInteractorInterface
extension ArticleDetailsInteractor: ArticleDetailsInteractorInterface {
    var title: String {
        return article.title
    }
    
    var authorName: String {
        return article.authorName
    }
    
    var imageName: String? {
        return article.imageName
    }
    
    var text: String {
        return article.text
    }
}
