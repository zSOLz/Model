//
//  UserDataSession.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

class UserDataSession {
    var profile: UserProfile
    var authenticationToken: String
    
    init(profile: UserProfile, authenticationToken: String) {
        self.profile = profile
        self.authenticationToken = authenticationToken
    }
}
