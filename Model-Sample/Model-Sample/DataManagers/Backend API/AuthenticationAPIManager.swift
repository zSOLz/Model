//
//  AuthenticationAPIManager.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

final class AuthenticationAPIManager {
    func registerUser(registrationInfo: UserRegistrationData, completion: @escaping (Result<UserAuthData, Error>) -> Void) {
        // Simulate backend access delay
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            completion(Backend.registerUser(registrationInfo: registrationInfo))
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<UserAuthData, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            completion(Backend.loginUser(email: email, password: password))
        }
    }
}
