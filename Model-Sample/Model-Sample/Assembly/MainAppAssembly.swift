//
//  MainAppAssembly.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/25/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class MainAppAssembly: Assembly {
    static func makeMainUserCoordinator(with authData: UserAuthData, parent: Coordinator) -> MainUserCoordinator {
        return MainUserCoordinator(with: authData, parent: parent)
    }
    
    static func makeUserDataSession(with authData: UserAuthData) -> UserDataSession {
        return UserDataSession(profile: authData.profile, authenticationToken: authData.token)
    }
}
