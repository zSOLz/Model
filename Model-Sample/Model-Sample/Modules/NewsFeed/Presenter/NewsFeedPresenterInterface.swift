//
//  NewsFeedPresenterInterface.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

struct NewsFeedArticleViewModel {
    let title: String
    let image: UIImage?
    let author: String
}

protocol NewsFeedPresenterInterface: PresenterInterface {
    var numberOfArticles: Int { get }
    func articleViewModel(at articleIndex: Int) -> NewsFeedArticleViewModel
    
    func articleTapped(at articleIndex: Int)
}
