//
//  NewsFeedDataManagerInterface.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

protocol NewsFeedDataManagerInterface {
    func loadNews(success: (([NewsFeedArticle])->Void)?, failure: ((Error)->Void)?)
}
