//
//  UsersAssembly.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/24/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class ProfileAssembly: Assembly {
    static func makeUsersInteractor(resolver: Resolver) -> UsersInteractor {
        let userDataSession = resolver.resolve(UserDataSession.self)
        return UsersInteractor(usersApiManager: UsersAPIManager(token: userDataSession.authenticationToken),
                               userDataSession: userDataSession,
                               usersCache: resolver.resolve(UsersCache.self))
    }
}

extension UsersCache: Resolvable {}
