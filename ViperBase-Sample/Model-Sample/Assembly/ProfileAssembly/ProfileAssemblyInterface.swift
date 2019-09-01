//
//  ProfileAssemblyInterface.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

protocol ProfileAssemblyInterface: AssemblyInterface {
    func userWlcomeViewController() -> UserWelcomeViewController
    func userProfileViewController() -> UserProfileViewController
    func registrationRouter() -> RegistrationRouter
}
