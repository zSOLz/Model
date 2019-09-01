//
//  ArticleDetailsPresenter.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

final class ArticleDetailsPresenter: Presenter {
    fileprivate var articleDetailsInteractor: ArticleDetailsInteractorInterface
    
    init(router: RouterInterface, articleDetailsInteractor: ArticleDetailsInteractorInterface) {
        self.articleDetailsInteractor = articleDetailsInteractor
        
        super.init(router: router)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupArticle()
    }
    
    fileprivate func setupArticle() {
        var articleImage: UIImage? = nil
        if let imageName = articleDetailsInteractor.imageName {
            articleImage = UIImage(named: imageName)
        }

        let viewModel = ArticleDetailsViewModel(title: articleDetailsInteractor.title,
                                                image: articleImage,
                                                author: articleDetailsInteractor.authorName,
                                                text: articleDetailsInteractor.text)
        view?.setup(viewModel: viewModel)
    }
}

// MARK: - Fileprivate
fileprivate extension ArticleDetailsPresenter {
    final var view: ArticleDetailsViewInterface? {
        return viewInterface as? ArticleDetailsViewInterface
    }
    
    final var router: NewsFeedRouterInterface? {
        return routerInterface as? NewsFeedRouterInterface
    }
}

// MARK: - ArticleDetailsPresenterInterface
extension ArticleDetailsPresenter: ArticleDetailsPresenterInterface {
    func closeButtonTapped() {
        router?.closeCurrentView()
    }
}
