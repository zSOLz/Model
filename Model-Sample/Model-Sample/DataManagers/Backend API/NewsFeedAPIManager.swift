//
//  FeedAPIManager.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

final class FeedAPIManager {
    let token: String
    init(token: String) {
        self.token = token
    }
    
    func newsFeed(completion: @escaping (Result<[NewsFeedItem], Error>) -> Void) {
        // Simulate internet delay
        // httpDataSource.get(endpoint: "newsFeed", completion: ... )
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            completion(Backend.newsFeed(token: self.token))
        }
    }

    func feed(profileId: UserProfile.Id, completion: @escaping (Result<[NewsFeedItem], Error>) -> Void) {
        // Simulate internet delay
        // httpDataSource.get(endpoint: "newsFeed", completion: ... )
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            completion(Backend.feed(profileId: profileId))
        }
    }
    
    func newsFeedItem(withId itemId: UserProfile.Id, completion: @escaping (Result<NewsFeedItem, Error>) -> Void) {
        // Simulate internet delay
        // httpDataSource.get(endpoint: "newsFeedItem", param: ["id": itemId], completion: ... )
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            completion(Backend.newsFeedItem(withId: itemId))
        }
    }
    
    func addItem(text: String?, image: UIImage?, completion: @escaping (Result<NewsFeedItem, Error>) -> Void) {
        guard text != nil || image != nil else {
            completion(.failure(GenericError.invalidParameters))
            return
        }
        
        // Simulate internet delay
        // httpDataSource.get(endpoint: "addItem", param: ["text": itemId, "image": imageId], completion: ... )

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            completion(Backend.addItem(token: self.token, text: text, image: image))
        }
    }
}
