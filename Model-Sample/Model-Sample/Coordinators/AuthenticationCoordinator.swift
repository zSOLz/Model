//
//  AuthenticationCoordinator.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class AuthenticationCoordinator: NavigationCoordinator {
    var registrationSucceededClosure: (UserAuthData) -> Void = { _ in }

    init(parent: Coordinator) {
        super.init(parent: parent)
        
        register(AuthenticationAssembly.makeUserRegistrationDataSession())
        
        showRegistrationScreen()
    }
}

extension AuthenticationCoordinator {
    func showRegistrationScreen() {
        
    }
}
