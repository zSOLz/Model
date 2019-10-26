//
//  LoginInteractor.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class LoginInteractor: Interactor {
    private let authenticationAPIManager: AuthenticationAPIManager

    init(authenticationAPIManager: AuthenticationAPIManager) {
        self.authenticationAPIManager = authenticationAPIManager
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Apply simple validation rules
        return (email.count >= 3 &&
                email.contains("@") &&
                email.contains("."))
    }

    func login(email: String, password: String, completion: @escaping (Result<UserAuthData, Error>) -> Void) {
        guard isValidEmail(email), isValidPassword(password) else {
            completion(.failure(GenericError.invalidParameters))
            return
        }
        authenticationAPIManager.login(email: email, password: password, completion: completion)
    }
}
