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
        
        showLoginScreen()
    }
}

extension AuthenticationCoordinator {
    func showLoginScreen() {
        let loginViewController = AuthenticationAssembly.makeLoginViewController()
        loginViewController.openRegistrationClosure = { [weak self] in
            self?.showRegistrationScreen()
        }
        loginViewController.loginSucceededClosure = { [weak self] userData in
            self?.registrationSucceededClosure(userData)
        }
        pushViewController(loginViewController)
    }

    func showRegistrationScreen() {
        let registrationViewController = AuthenticationAssembly.makeRegistrationViewController(resolver: self)
        registrationViewController.nextClosure = { [weak self] in
            self?.showPasswordScreen()
        }
        pushViewController(registrationViewController)
    }
    
    func showPasswordScreen() {
        let passwordViewController = AuthenticationAssembly.makePasswordViewController(resolver: self)
        passwordViewController.registrationSucceededClosure = { [weak self] userData in
            self?.registrationSucceededClosure(userData)
        }
        pushViewController(passwordViewController)
    }
}
