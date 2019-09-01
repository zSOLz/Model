//
//  UserRegistrationDataManagerInterface.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

struct UserRegistrationResult {
    let token: String
}

protocol UserRegistrationDataManagerInterface: NSObjectProtocol {
    func registerUser(registrationInfo: UserRegistrationInfo,
                      success: ((UserRegistrationResult)->Void)?,
                      failure: ((Error)->Void)?)
}
