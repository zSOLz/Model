//
//  RegistrationRouterInterface.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

protocol RegistrationRouterInterface: RouterInterface {
    func showCredentialsScreen()
    func completeRegistration()
    func cancelRegistration()
}
