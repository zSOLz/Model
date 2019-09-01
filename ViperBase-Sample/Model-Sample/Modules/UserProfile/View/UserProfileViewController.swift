//
//  UserProfileViewController.swift
//  Model-Sample
//
//  Created by SOL on 09.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

final class UserProfileViewController: PresentableViewController {
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var tokenLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        presenter?.logoutButtonTapped()
    }
}

// MARK: - Fileprivate
fileprivate extension UserProfileViewController {
    final var presenter: UserProfilePresenterInterface? {
        return presenterInterface as? UserProfilePresenterInterface
    }
}

// MARK: - UserProfileViewInterface
extension UserProfileViewController: UserProfileViewInterface {
    func setup(viewModel: UserProfileViewModel) {
        usernameLabel.text = viewModel.username
        emailLabel.text = viewModel.email
        tokenLabel.text = viewModel.token
    }
}

// MARK: - ContentContainerInterface
extension UserProfileViewController {
    override func setupContent() {
        super.setupContent()
        
        title = "User"
    }
}
