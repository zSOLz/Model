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
                                                                         image: UIImage(systemName: "line.horizontal.3"),
                                                                         selectedImage: nil)
        
        let friendsCoordinator = ProfileAssembly.makeFriendCoordinator(parent: self)
        friendsCoordinator.baseViewController.tabBarItem = UITabBarItem(title: "Ferinds",
                                                                        image: UIImage(systemName: "person.3.fill"),
                                                                        selectedImage: nil)
        
        let moreCoordinator = ProfileAssembly.makeMoreCoordinator(parent: self)
        moreCoordinator.baseViewController.tabBarItem = UITabBarItem(title: "More",
                                                                     image: UIImage(systemName: "ellipsis.circle"),
                                                                     selectedImage: nil)
        moreCoordinator.logoutClosure = { [weak self] in
            self?.logoutClosure()
        }
        
        let coordinators = [newsFeedCoordinator, friendsCoordinator, moreCoordinator]
        coordinators.forEach { add(child: $0) }

        tabBarController.viewControllers = coordinators.map { $0.baseViewController }
    }
}
