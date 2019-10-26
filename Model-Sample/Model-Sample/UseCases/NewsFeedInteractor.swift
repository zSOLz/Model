//
//  NewsFeedInteractor.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class NewsFeedInteractor: Interactor {
    private let newsFeedCache: NewsFeedCache
    private let feedAPIManager: FeedAPIManager
    
    init(newsFeedCache: NewsFeedCache,
         newsFeedAPIManager: FeedAPIManager) {
        self.newsFeedCache = newsFeedCache
        self.feedAPIManager = newsFeedAPIManager
        
        super.init()
    }

    func myNewsFeed(completion: @escaping (Result<[NewsFeedItem], Error>) -> Void) {
        feedAPIManager.newsFeed(completion: { [weak self] result in
            result.onSuccess { items in
                for item in items {
                    self?.newsFeedCache.feedItems[item.id] = item
                }
            }
            completion(result)
        })
    }
    
    func feed(profileId: UserProfile.Id, completion: @escaping (Result<[NewsFeedItem], Error>) -> Void) {
        feedAPIManager.feed(profileId: profileId, completion: { [weak self] result in
            result.onSuccess { items in
                for item in items {
                    self?.newsFeedCache.feedItems[item.id] = item
                }
            }
            completion(result)
        })
    }
    
    func newsFeedItem(withId itemId: NewsFeedItem.Id, completion: @escaping (Result<NewsFeedItem, Error>) -> Void) {
        if let item = newsFeedCache.feedItems[itemId] {
            completion(.success(item))
            return
        }
        feedAPIManager.newsFeedItem(withId: itemId) { [weak self] result in
            result.onSuccess { self?.newsFeedCache.feedItems[$0.id] = $0 }
            completion(result)
        }
    }
}
