//
//  ProfileRouter.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class ProfileRouter: StackRouter {
    let profileAssembly: ProfileAssemblyInterface
    
    init(profileAssembly: ProfileAssemblyInterface) {
        self.profileAssembly = profileAssembly
    }
    
    override func loadNavigationController() {
        super.loadNavigationController()
        
        showUserWelcomeScreen()
    }
}

// MARK: - ProfileRouterInterface
extension ProfileRouter: ProfileRouterInterface {
    func showUserProfileScreen() {
        navigationController.viewControllers = [profileAssembly.userProfileViewController()]
    }
    
    func showUserWelcomeScreen() {
        navigationController.viewControllers = [profileAssembly.userWlcomeViewController()]
    }
    
    func showRegistrationScreen() {
        let registrationRouter = profileAssembly.registrationRouter()
        
        registrationRouter.completionClosure = { [weak self, unowned registrationRouter] in
            self?.showUserProfileScreen()
            self?.dismissModalRouter(registrationRouter)
        }
        
        registrationRouter.cancelClosure = { [weak self, unowned registrationRouter] in
            self?.dismissModalRouter(registrationRouter)
        }
        
        // Add router as child to keep strong reference
        presentModalRouter(registrationRouter, animated: true)
    }
}
