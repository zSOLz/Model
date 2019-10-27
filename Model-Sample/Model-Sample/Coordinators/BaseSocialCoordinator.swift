//
//  BaseSocialCoordinator.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/27/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class BaseSocialCoordinator: NavigationCoordinator {
    func openProfileScreen(with id: UserProfile.Id) {
        let profileViewController = ProfileAssembly.makeUserProfileViewController(profileId: id, resolver: self)
        profileViewController.openFeedItemClosure = { [weak self] itemId in
            self?.showFeedItemScreen(with: itemId)
        }
        profileViewController.openFriendsList = { [weak self] profileId in
            self?.showFriendsListScreen(for: profileId)
        }
        profileViewController.hidesBottomBarWhenPushed = true
        pushViewController(profileViewController)
    }
    
    func showFeedItemScreen(with itemId: NewsFeedItem.Id) {
        let feedItemViewController = NewsFeedAssembly.makeFeedItemDetailsViewController(feedItemId: itemId, resolver: self)
        feedItemViewController.openProfileClosure = { [weak self] profileId in
            self?.openProfileScreen(with: profileId)
        }
        feedItemViewController.hidesBottomBarWhenPushed = true
        pushViewController(feedItemViewController)
    }
    
    func showFriendsListScreen(for profileId: UserProfile.Id) {
        let friendsViewController = ProfileAssembly.makeFriendsViewController(profileId: profileId, resolver: self)
        friendsViewController.openProfileClosure = { [weak self] profileId in
            self?.openProfileScreen(with: profileId)
        }
        friendsViewController.hidesBottomBarWhenPushed = true
        pushViewController(friendsViewController)
    }
}
