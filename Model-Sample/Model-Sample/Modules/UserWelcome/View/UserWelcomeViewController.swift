//
//  UserWelcomeViewController.swift
//  Model-Sample
//
//  Created by SOL on 09.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class UserWelcomeViewController: PresentableViewController {
    @IBAction func registerButtonTapped(_ sender: Any) {
        presenter?.registerButtonTapped()
    }
}

// MARK: - Fileprivate
fileprivate extension UserWelcomeViewController {
    final var presenter: UserWelcomePresenterInterface? {
        return presenterInterface as? UserWelcomePresenterInterface
    }
}

// MARK: - UserWelcomeViewInterface
extension UserWelcomeViewController: UserWelcomeViewInterface {
    // Empty
}

// MARK: - ContentContainerInterface
extension UserWelcomeViewController {
    override func setupContent() {
        super.setupContent()
        
        title = "Welcome!"
    }
}
