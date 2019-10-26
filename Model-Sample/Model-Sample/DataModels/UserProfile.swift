//
//  UserProfile.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

struct UserProfile {
    typealias Id = String
    
    var id: Id
    var username: String
    var email: String
    var avatarURL: URL?
}
