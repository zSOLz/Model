//
//  NewsFeedInteractor.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

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
            let sortedResult = result.map { $0.sorted { $0.date > $1.date } }
            completion(sortedResult)
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
    
    func addItem(text: String?, image: UIImage?, completion: @escaping (Result<NewsFeedItem, Error>) -> Void) {
        feedAPIManager.addItem(text: text, image: image, completion: { [weak self] result in
            result.onSuccess { self?.newsFeedCache.feedItems[$0.id] = $0 }
            completion(result)
        })
    }
    
    func comments(useCache: Bool, feedItemId: NewsFeedItem.Id, completion: @escaping(Result<[FeedItemComment], Error>) -> Void) {
        if useCache {
            let items = newsFeedCache.feedItemComments[feedItemId] ?? []
            completion(.success(items))
        } else {
            feedAPIManager.comments(feedItemId: feedItemId, completion: { [weak self] result in
                let sortedResult = result.map { $0.sorted(by: { $0.date > $1.date }) }
                sortedResult.onSuccess { comments in
                    self?.newsFeedCache.feedItemComments[feedItemId] = comments
                }
                completion(sortedResult)
            })
        }
    }
    
    func addComment(feedItemId: NewsFeedItem.Id, text: String, completion: @escaping(Result<FeedItemComment, Error>) -> Void) {
        feedAPIManager.addComments(feedItemId: feedItemId, text: text, completion: { [weak self] result in
            result.onSuccess { comment in
                self?.newsFeedCache.feedItemComments[feedItemId, default: []].insert(comment, at: 0)
            }
            completion(result)
        })
    }
}
