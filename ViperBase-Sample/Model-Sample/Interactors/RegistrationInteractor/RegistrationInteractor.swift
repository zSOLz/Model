//
//  RegistrationInteractor.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class RegistrationInteractor: Interactor {
    fileprivate let userRegistrationDataSession: UserRegistrationDataSession
    fileprivate let userDataSession: UserDataSession
    fileprivate let registrationDataManager: UserRegistrationDataManagerInterface

    init(userRegistrationDataSession: UserRegistrationDataSession,
         userDataSession: UserDataSession,
         registrationDataManager: UserRegistrationDataManagerInterface) {
        self.userRegistrationDataSession = userRegistrationDataSession
        self.userDataSession = userDataSession
        self.registrationDataManager = registrationDataManager
    }
}

// MARK: - RegistrationInteractorInterface
extension RegistrationInteractor: RegistrationInteractorInterface {
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
            return userRegistrationDataSession.info.username ?? ""
        }
        set {
            guard isValidUsername(newValue) else {
                assertionFailure("Attempt to assign invalid username")
                return
            }
            userRegistrationDataSession.info.username = newValue
        }
    }
    
    var password: String {
        get {
            return userRegistrationDataSession.info.password ?? ""
        }
        set {
            guard isValidPassword(newValue) else {
                assertionFailure("Attempt to assign invalid password")
                return
            }
            userRegistrationDataSession.info.password = newValue
        }
    }
    
    var email: String {
        get {
            return userRegistrationDataSession.info.email ?? ""
        }
        set {
            guard isValidEmail(newValue) else {
                assertionFailure("Attempt to assign invalid email")
                return
            }
            userRegistrationDataSession.info.email = newValue
        }
    }
    
    func registerUser(success: (() -> Void)?, failure: ((Error) -> Void)?) {
        registrationDataManager.registerUser(registrationInfo: userRegistrationDataSession.info, success: { [weak self] registrationResult in
            guard let profile = self?.userRegistrationDataSession.info.userProfile else {
                failure?(ApplicationError(message: "Could not create user profiles"))
                return
            }
            self?.userDataSession.profile = profile
            self?.userDataSession.authenticationToken = registrationResult.token
            success?()
        }, failure: failure)
    }
}

fileprivate extension UserRegistrationInfo {
    var userProfile: UserProfile? {
        guard let email = email, let username = username else {
            assertionFailure("Attempt to create user profile with undefined data")
            return nil
        }
        return UserProfile(email: email, username: username)
    }
}
