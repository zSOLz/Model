//
//  RegistrationCredentialsViewInterface.swift
//  Model-Sample
//
//  Created by SOL on 09.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

protocol RegistrationCredentialsViewInterface: ViewInterface {
    func setSubmitButton(enabled: Bool)
    func setSetRepeatPasswordError(hidden: Bool)
    func setActivityIndicator(visible: Bool)
    func stopEditing()
}
