//
//  NewsFeedDataManager.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

final class NewsFeedDataManager: NSObject {
    // Empty
}

// MARK: - NewsFeedDataManagerInterface
extension NewsFeedDataManager: NewsFeedDataManagerInterface {
    func loadNews(success: (([NewsFeedArticle])->Void)?, failure: ((Error)->Void)?) {
        // Simulate internet delay
        // httpDataSource.get(endpoint: "newsFeed", success: ... , failure: ... )
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            var articles = [NewsFeedArticle]()
            
            articles.append(NewsFeedArticle(articleId: "4",
                                            title: "How to open details page",
                                            authorName: "Andrew Solovey",
                                            imageName: "arhitecture-1",
                                            text: "Pass item ID to router and then build correct controller with correct parameters.\n\n" +
                                                  "See call stack:\nNewsFeedViewController.tableView(_:didSelectRowAt:)\n" +
                                                  "NewsFeedPresenterInterface.articleTapped(at:)\n" +
                                                  "NewsFeedRouter.showArticleDetails(with:)\n" +
                                                  "NewsFeedAssembly.articleDetailsViewController(withArticleId:)"))

            articles.append(NewsFeedArticle(articleId: "1",
                                            title: "Preview for May FOMC",
                                            authorName: "Christopher Vecchio",
                                            imageName: "finance-1",
                                            text: "Without new economic projections today or a press conferece, there's no shot the Fed raises rates. Instead, look to the policy statement to be the catalyst for price action."))
            
            articles.append(NewsFeedArticle(articleId: "2",
                                            title: "Charts Ahead of FOMC",
                                            authorName: "Ilya Spivak",
                                            imageName: "finance-2",
                                            text: "Today, we started off by looking at the US Dollar Index (DXY) ahead of the FOMC rate decision and policy statement later today. No expectation of a move out of the Fed, so traders will focus on the language in the statement for clues as to future moves."))
            
            articles.append(NewsFeedArticle(articleId: "3",
                                            title: "News in VIPER Arhitecture",
                                            authorName: "Andrew Solovey",
                                            imageName: nil,
                                            text: "Eurozone GDP figures headline the economic calendar in European trading hours. The on-year growth rate is expected to register at 1.7 percent in the first quarter, unchanged from the three months through December 2016. The quarterly gain is projected at 0.5 percent, also a repeat of the prior period."))

            articles.append(NewsFeedArticle(articleId: "5",
                                            title: "Ecstatic advanced and procured civility not absolute put continue",
                                            authorName: "Vangelis Bibakis",
                                            imageName: nil,
                                            text: "Woody equal ask saw sir weeks aware decay. Entrance prospect removing we packages strictly is no smallest he. For hopes may chief get hours day rooms. Oh no turned behind polite piqued enough at. Forbade few through inquiry blushes you."))

            articles.append(NewsFeedArticle(articleId: "6",
                                            title: "An Introduction to Functional Programming in Swift",
                                            authorName: "Niv Yahel",
                                            imageName: "arhitecture-2",
                                            text: "Swift’s grand entrance to the programming world at WWDC in 2014 was much more than just an introduction of a new language. It brought a number of new approaches to software development for the iOS and macOS platforms."))

            // Call success copmlete data loading
            success?(articles)
        }
    }
}
