//
//  FriendsCoordinator.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/24/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class FriendsCoordinator: BaseSocialCoordinator {
    init(parent: Coordinator) {
        super.init(parent: parent)
        
        showFriendsScreen()
    }
}

//MARK: - Private
private extension FriendsCoordinator {
    func showFriendsScreen() {
        let friendsViewController = ProfileAssembly.makeMyFriendsViewController(resolver: self)
        friendsViewController.openProfileClosure = { [weak self] profileId in
            self?.openProfileScreen(with: profileId)
        }
        pushViewController(friendsViewController)
    }
}
