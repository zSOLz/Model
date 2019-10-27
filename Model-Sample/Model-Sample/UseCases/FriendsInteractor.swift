//
//  FriendsInteractor.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/22/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Foundation

class FriendsInteractor {
    private let usersCache: UsersCache
    private let usersApiManager: UsersAPIManager

    init(usersApiManager: UsersAPIManager,
         usersCache: UsersCache) {
        self.usersApiManager = usersApiManager
        self.usersCache = usersCache
    }

    func myFriends(completion: @escaping (Result<[UserProfile], Error>) -> Void) {
        usersApiManager.friends(completion: { [weak self] result in
            result.onSuccess { profiles in
                for profile in profiles {
                    self?.usersCache.users[profile.id] = profile
                }
            }
            completion(result)
        })
    }
    
    func friends(forProfileId profileId: UserProfile.Id, completion: @escaping (Result<[UserProfile], Error>) -> Void) {
        usersApiManager.friends(profileId: profileId, completion: { [weak self] result in
            result.onSuccess { profiles in
                for profile in profiles {
                    self?.usersCache.users[profile.id] = profile
                }
            }
            completion(result)
        })
    }
}
