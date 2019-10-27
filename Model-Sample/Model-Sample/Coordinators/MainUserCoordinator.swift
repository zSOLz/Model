//
//  MainUserCoordinator.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/24/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model
import UIKit

class MainUserCoordinator: TabCoordinator {
    var logoutClosure: () -> Void = {}
    
    init(with authData: UserAuthData, parent: Coordinator) {
        super.init(parent: parent)
        
        register(MainAppAssembly.makeUserDataSession(with: authData))
        register(NewsFeedAssembly.makeNewsFeedCache())

        let usersCache = ProfileAssembly.makeUsersCache()
        usersCache.users[authData.profile.id] = authData.profile
        register(usersCache)
        
        setupTabs()
    }
}

// MARK: - Private
private extension MainUserCoordinator {
    func setupTabs() {
        let newsFeedCoordinator = NewsFeedAssembly.makeNewsFeedCoordinator(parent: self)
        newsFeedCoordinator.baseViewController.tabBarItem = UITabBarItem(title: "News",
                                                                         image: nil,
                                                                         selectedImage: nil) // TODO: images
        
        let friendsCoordinator = ProfileAssembly.makeFriendCoordinator(parent: self)
        friendsCoordinator.baseViewController.tabBarItem = UITabBarItem(title: "Ferinds",
                                                                        image: nil,
                                                                        selectedImage: nil) // TODO: images
        
        let moreCoordinator = ProfileAssembly.makeMoreCoordinator(parent: self)
        moreCoordinator.baseViewController.tabBarItem = UITabBarItem(title: "More",
                                                                     image: nil,
                                                                     selectedImage: nil) // TODO: images
        moreCoordinator.logoutClosure = { [weak self] in
            self?.logoutClosure()
        }
        
        let coordinators = [newsFeedCoordinator, friendsCoordinator, moreCoordinator]
        coordinators.forEach { add(child: $0) }

        tabBarController.viewControllers = coordinators.map { $0.baseViewController }
    }
}
