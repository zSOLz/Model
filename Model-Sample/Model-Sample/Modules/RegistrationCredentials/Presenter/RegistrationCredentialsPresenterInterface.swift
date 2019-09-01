//
//  RegistrationCredentialsPresenterInterface.swift
//  Model-Sample
//
//  Created by SOL on 09.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

protocol RegistrationCredentialsPresenterInterface: PresenterInterface {
    func submitButtonTapped()
    func usernameChanged(_ username: String)
    func passwordChanged(_ password: String)
    func repeatPasswordChanged(_ repeatPassword: String)
}
