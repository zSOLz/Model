//
//  ProfileAssembly.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class ProfileAssembly: Assembly {
    /// userDataSession represents user state in application.
    /// DataSessions layer is the place to keep app mutable application state.
    fileprivate var userDataSession = UserDataSession()
    fileprivate weak var innerProfileRouter: ProfileRouter?
    
    func profileRouter() -> ProfileRouter {
        if let profileRouter = innerProfileRouter {
            return profileRouter
        } else {
            let profileRouter = ProfileRouter(profileAssembly: self)
            innerProfileRouter = profileRouter
            return profileRouter
        }
    }
}

// MARK: - ProfileAssemblyInterface
extension ProfileAssembly: ProfileAssemblyInterface {
    func userWlcomeViewController() -> UserWelcomeViewController {
        let presenter = UserWelcomePresenter(router: profileRouter())
        let view = UserWelcomeViewController()
        
        view.presenterInterface = presenter
        
        return view
    }
    
    func userProfileViewController() -> UserProfileViewController {
        let interactor = UserProfileInteractor(userDataSession: userDataSession)
        let presenter = UserProfilePresenter(router: profileRouter(), userProfileInteractor: interactor)
        let view = UserProfileViewController()
        
        view.presenterInterface = presenter
        
        return view
    }
    
    func registrationRouter() -> RegistrationRouter {
        let registrationAssembly = RegistrationAssembly(userDataSession: userDataSession)
        return registrationAssembly.registrationRouter()
    }
}
