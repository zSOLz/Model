//
//  AuthenticationAssembly.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class AuthenticationAssembly: Assembly {
    static func makeAuthenticationCoordinator(parent: Coordinator) -> AuthenticationCoordinator {
        return AuthenticationCoordinator(parent: parent)
    }
    
    static func makeUserRegistrationDataSession() -> UserRegistrationDataSession {
        return UserRegistrationDataSession()
    }
    
    static func makeLoginInteractor() -> LoginInteractor {
        return LoginInteractor(authenticationAPIManager: AuthenticationAPIManager())
    }
    
    static func makeRegistrationInteractor(resolver: Resolver) -> RegistrationInteractor {
        return RegistrationInteractor(userRegistrationDataSession: resolver.resolve(UserRegistrationDataSession.self),
                                      authenticationAPIManager: AuthenticationAPIManager())
    }
    
    static func makeLoginViewController() -> LoginViewController {
        return LoginViewController(loginInteractor: makeLoginInteractor())
    }
    
    static func makeRegistrationViewController(resolver: Resolver) -> RegistrationViewController {
        return RegistrationViewController(registrationInteractor: makeRegistrationInteractor(resolver: resolver))
    }

    static func makePasswordViewController(resolver: Resolver) -> PasswordViewController {
        return PasswordViewController(registrationInteractor: makeRegistrationInteractor(resolver: resolver))
    }
}

extension UserRegistrationDataSession: Resolvable {}
extension UserDataSession: Resolvable {}
