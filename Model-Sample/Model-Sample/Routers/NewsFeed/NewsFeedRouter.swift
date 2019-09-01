//
//  NewsFeedRouter.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class NewsFeedRouter: StackRouter {
    let newsFeedAssembly: NewsFeedAssemblyInterface
    
    init(newsFeedAssembly: NewsFeedAssemblyInterface) {
        self.newsFeedAssembly = newsFeedAssembly
    }
    
    override public func loadNavigationController() {
        super.loadNavigationController()
        
        navigationController.viewControllers = [newsFeedAssembly.newsFeedViewController()]
    }
}

// MARK: - NewsFeedRouterInterface
extension NewsFeedRouter: NewsFeedRouterInterface {
    func showArticleDetails(with articleId: NewsFeedArticleId) {
        let articleDetailsController = newsFeedAssembly.articleDetailsViewController(withArticleId: articleId)
        navigationController.pushViewController(articleDetailsController, animated: true)
    }
}
