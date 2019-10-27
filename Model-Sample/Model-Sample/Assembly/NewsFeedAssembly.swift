//
//  NewsFeedAssembly.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/24/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model
import UIKit

class NewsFeedAssembly: Assembly {
    static func makeNewsFeedCoordinator(parent: Coordinator) -> NewsFeedCoordinator {
        return NewsFeedCoordinator(parent: parent)
    }
    
    static func makeNewsFeedCache() -> NewsFeedCache {
        return NewsFeedCache()
    }
    
    static func makeNewsFeedInteractor(resolver: Resolver) -> NewsFeedInteractor {
        let token = resolver.resolve(UserDataSession.self).authenticationToken
        return NewsFeedInteractor(newsFeedCache: resolver.resolve(NewsFeedCache.self),
                                  newsFeedAPIManager: FeedAPIManager(token: token))
    }
    
    static func makeNewsFeedViewController(resolver: Resolver) -> NewsFeedViewController {
        return NewsFeedViewController(newsFeedInteractor: makeNewsFeedInteractor(resolver: resolver),
                                      usersInteractor: ProfileAssembly.makeUsersInteractor(resolver: resolver))
    }
    
    static func makeFeedItemDetailsViewController(feedItemId: NewsFeedItem.Id, resolver: Resolver) -> FeedItemDetailsViewController {
        return FeedItemDetailsViewController(feedItemId: feedItemId,
                                             usersInteractor: ProfileAssembly.makeUsersInteractor(resolver: resolver),
                                             newsFeedInteractor: makeNewsFeedInteractor(resolver: resolver))
    }
    
    static func makeNewPostViewController(resolver: Resolver) -> (NewPostViewController, UINavigationController) {
        let newsFeedInteractor = makeNewsFeedInteractor(resolver: resolver)
        let newPostViewController = NewPostViewController(newsFeedInteractor: newsFeedInteractor)
        let navigationController = UINavigationController(rootViewController: newPostViewController)
        return (newPostViewController, navigationController)
    }
}

extension NewsFeedCache: Resolvable {}
