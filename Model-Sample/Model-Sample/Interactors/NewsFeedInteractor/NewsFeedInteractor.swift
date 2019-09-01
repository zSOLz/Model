//
//  NewsFeedInteractor.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class NewsFeedInteractor: Interactor {
    fileprivate let newsFeedDataSession: NewsFeedDataSession
    fileprivate let newsFeedDataManager: NewsFeedDataManager
    
    init(newsFeedDataSession: NewsFeedDataSession,
         newsFeedDataManager: NewsFeedDataManager) {
        self.newsFeedDataSession = newsFeedDataSession
        self.newsFeedDataManager = newsFeedDataManager
    }
}

// MARK: - NewsFeedInteractorInterface
extension NewsFeedInteractor: NewsFeedInteractorInterface {
    func updateArticles(success: (()->Void)?, failure: ((Error)->Void)?) {
        self.newsFeedDataManager.loadNews(success: { [weak self] articles in
            self?.newsFeedDataSession.articles = articles
            success?()
        }, failure: { error in
            failure?(error)
        })
    }
    
    var numberOfArticles: Int {
        return newsFeedDataSession.articles.count
    }
    
    func articleId(at index: Int) -> NewsFeedArticleId {
        return newsFeedDataSession.articles[index].articleId
    }
}
