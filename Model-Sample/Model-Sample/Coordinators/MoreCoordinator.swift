//
//  MoreCoordinator.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/24/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class MoreCoordinator: BaseSocialCoordinator {
    var logoutClosure: () -> Void = {}
    
    init(parent: Coordinator) {
        super.init(parent: parent)
        
        showMoreViewController()
    }
}

// MARK: - Private
private extension MoreCoordinator {
    func showMoreViewController() {
        let moreViewController = ProfileAssembly.makeMoreViewController(resolver: self)
        moreViewController.openProfileClosure = { [weak self] profileId in
            self?.openProfileScreen(with: profileId)
        }
        moreViewController.logoutClosure = { [weak self] in
            self?.logoutClosure()
        }
        pushViewController(moreViewController)
    }
}
