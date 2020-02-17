//
//  NewsFeedCoordinator.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/24/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class NewsFeedCoordinator: BaseSocialCoordinator {
    init(parent: Coordinator) {
        super.init(parent: parent)
        
        showNewsFeedScreen()
    }
}

//MARK: - Private
private extension NewsFeedCoordinator {
    func showNewsFeedScreen() {
        let newsFeedViewController = NewsFeedAssembly.makeNewsFeedViewController(resolver: self)
        newsFeedViewController.openFeedItemClosure = { [weak self] itemId in
            self?.showFeedItemScreen(with: itemId)
        }
        newsFeedViewController.openProfileClosure = { [weak self] profileId in
            self?.openProfileScreen(with: profileId)
        }
        newsFeedViewController.newPostClosure = { [weak self] in
            self?.showNewPostScreen()
        }
        pushViewController(newsFeedViewController)
    }
    
    func showNewPostScreen() {
        let (newPostViewController, navigationController) = NewsFeedAssembly.makeNewPostViewController(resolver: self)
        newPostViewController.closeClosure = { [weak self] in
            self?.dismissModalController()
        }
        presentModal(controller: navigationController, presentationStyle: .automatic)
    }
}
