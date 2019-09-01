//
//  NewsFeedAssembly.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class NewsFeedAssembly: Assembly {
    /// One instance of this router will be assigned to all presenters inside current module.
    /// 'Weak' specifier was used to break retain cycle: View > Presenter > Router > View.
    fileprivate weak var innerNewsFeedRouter: NewsFeedRouter?
    
    fileprivate var newsFeedDataSession = NewsFeedDataSession()
    
    func newsFeedRouter() -> NewsFeedRouter {
        if let newsFeedRouter = innerNewsFeedRouter {
            return newsFeedRouter
        } else {
            let router = NewsFeedRouter(newsFeedAssembly: self)
            innerNewsFeedRouter = router
            return router
        }
    }
}

// MARK: - ArticleDetailsInteractorBuilder
extension NewsFeedAssembly: ArticleDetailsInteractorBuilder {
    func articleDetailsInteractor(withArticleId articleId: NewsFeedArticleId) -> ArticleDetailsInteractorInterface {
        return ArticleDetailsInteractor(newsFeedDataSession: self.newsFeedDataSession, articleId: articleId)
    }
}

// MARK: - NewsFeedAssemblyInterface
extension NewsFeedAssembly: NewsFeedAssemblyInterface {
    func newsFeedViewController() -> NewsFeedViewController {
        let dataManager = NewsFeedDataManager()
        let interactor = NewsFeedInteractor(newsFeedDataSession: newsFeedDataSession,
                                            newsFeedDataManager: dataManager)
        let presenter = NewsFeedPresenter(router: newsFeedRouter(),
                                          newsFeedInteractor: interactor,
                                          detailsInteractorBuilder: self)
        
        let view = NewsFeedViewController()
        view.presenterInterface = presenter
        
        return view
    }
    
    func articleDetailsViewController(withArticleId articleId: NewsFeedArticleId) -> ArticleDetailsViewController {
        let interactor = articleDetailsInteractor(withArticleId: articleId)
        let presenter = ArticleDetailsPresenter(router: newsFeedRouter(), articleDetailsInteractor: interactor)
        let view = ArticleDetailsViewController()
        view.presenterInterface = presenter
        return view
    }
}
