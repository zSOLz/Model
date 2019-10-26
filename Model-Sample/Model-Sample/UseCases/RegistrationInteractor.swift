//
//  RegistrationInteractor.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

final class RegistrationInteractor: Interactor {
    private let userRegistrationDataSession: UserRegistrationDataSession
    private let authenticationAPIManager: AuthenticationAPIManager

    init(userRegistrationDataSession: UserRegistrationDataSession,
         authenticationAPIManager: AuthenticationAPIManager) {
        self.userRegistrationDataSession = userRegistrationDataSession
        self.authenticationAPIManager = authenticationAPIManager
    }

    func isValidUsername(_ username: String) -> Bool {
        // Apply simple validation rules
        return (username.count >= 3 && username.count <= 20)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        // Apply simple validation rules
        return password.count >= 8
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Apply simple validation rules
        return (email.count >= 3 &&
                email.contains("@") &&
                email.contains("."))
    }
    
    var username: String {
        get {
            return userRegistrationDataSession.username ?? ""
        }
        set {
            guard isValidUsername(newValue) else {
                assertionFailure("Attempt to assign invalid username")
                return
            }
            userRegistrationDataSession.username = newValue
        }
    }
    
    var password: String {
        get {
            return userRegistrationDataSession.password ?? ""
        }
        set {
            guard isValidPassword(newValue) else {
                assertionFailure("Attempt to assign invalid password")
                return
            }
            userRegistrationDataSession.password = newValue
        }
    }
    
    var email: String {
        get {
            return userRegistrationDataSession.email ?? ""
        }
        set {
            guard isValidEmail(newValue) else {
                assertionFailure("Attempt to assign invalid email")
                return
            }
            userRegistrationDataSession.email = newValue
        }
    }
    
    var avatar: UIImage? {
        get {
            return userRegistrationDataSession.avatar
        }
        set {
            guard newValue != nil else {
                assertionFailure("Attempt to assign invalid avatar")
                return
            }
            userRegistrationDataSession.avatar = newValue
        }
    }
    
    var isUserRegistrationDataValid: Bool {
        guard let username = userRegistrationDataSession.username,
            let password = userRegistrationDataSession.password,
            let email = userRegistrationDataSession.email,
            let _ = userRegistrationDataSession.avatar else {
                return false
        }
        return isValidEmail(email) && isValidUsername(username) && isValidPassword(password)
    }
    
    func registerUser(completion: @escaping (Result<UserAuthData, Error>) -> Void) {
        guard isUserRegistrationDataValid,
            let username = userRegistrationDataSession.username,
            let password = userRegistrationDataSession.password,
            let email = userRegistrationDataSession.email,
            let avatar = userRegistrationDataSession.avatar else {
                completion(.failure(GenericError.invalidUserRegistrationCredentials))
                return
        }
        let registrationData = UserRegistrationData(username: username,
                                                    password: password,
                                                    email: email,
                                                    avatar: avatar)
            
        authenticationAPIManager.registerUser(registrationInfo: registrationData, completion: completion)
    }
}
