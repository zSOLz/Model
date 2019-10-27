//
//  RootCoordinator.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit
import Model

class RootCoordinator: ContainerCoordinator {
    init() {
        super.init(parent: nil)
        
        showAuthentication()
    }
}

// MARK: - Private
private extension RootCoordinator {
    func showAuthentication() {
        let authenticationCoordinator = AuthenticationAssembly.makeAuthenticationCoordinator(parent: self)
        authenticationCoordinator.registrationSucceededClosure = { [weak self] authData in
            self?.showMainApp(with: authData)
        }
        self.contentCoordinator = authenticationCoordinator
    }
    
    func showMainApp(with authData: UserAuthData) {
        let mainUserCoordinator = MainAppAssembly.makeMainUserCoordinator(with: authData, parent: self)
        mainUserCoordinator.logoutClosure = { [weak self] in
            self?.showAuthentication()
        }
        self.contentCoordinator = mainUserCoordinator
    }
}
