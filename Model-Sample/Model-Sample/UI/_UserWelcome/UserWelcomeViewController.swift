//
//  UserWelcomeViewController.swift
//  Model-Sample
//
//  Created by SOL on 09.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

final class UserWelcomeViewController: ViewController {
    @IBAction func registerButtonTapped(_ sender: Any) {
        //presenter?.registerButtonTapped()
    }
    
    override func setupContent() {
        super.setupContent()
        
        title = "Welcome!"
    }
}

// MARK: - private
private extension UserWelcomeViewController {
    // Empty
}
