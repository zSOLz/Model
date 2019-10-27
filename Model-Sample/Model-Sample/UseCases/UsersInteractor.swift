//
//  UsersInteractor.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/19/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

final class UsersInteractor: Interactor {
    private let usersCache: UsersCache
    private let userDataSession: UserDataSession
    private let usersApiManager: UsersAPIManager

    init(usersApiManager: UsersAPIManager,
         userDataSession: UserDataSession,
         usersCache: UsersCache) {
        self.usersApiManager = usersApiManager
        self.userDataSession = userDataSession
        self.usersCache = usersCache
    }
    
    func myProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        completion(.success(userDataSession.profile))
    }
    
    func userProfile(withId profileId: UserProfile.Id, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        if let cachedProfile = usersCache.users[profileId] {
            completion(.success(cachedProfile))
        } else {
            usersApiManager.userProfile(withId: profileId, completion: { [weak self] result in
                result.onSuccess { profile in
                    self?.usersCache.users[profile.id] = profile
                }
                completion(result)
            })
        }
    }
    
    func userProfiles(withId profileIds: [UserProfile.Id], completion: @escaping (Result<[UserProfile], Error>) -> Void) {
        var profiles = [UserProfile]()
        var uncachedProfileIds = [UserProfile.Id]()
        for id in profileIds {
            if let cachedUser = usersCache.users[id] {
                profiles.append(cachedUser)
            } else {
                uncachedProfileIds.append(id)
            }
        }
        var loadNextProfileOrFinish = {}
        
        loadNextProfileOrFinish = { [weak self] in
            guard let lastProfileId = uncachedProfileIds.popLast() else {
                completion(.success(profiles))
                return
            }
            
            self?.usersApiManager.userProfile(withId: lastProfileId, completion: { profileResult in
                profileResult.on(success: { profile in
                    self?.usersCache.users[profile.id] = profile
                    profiles.append(profile)
                    loadNextProfileOrFinish()
                }, failure: { error in
                    completion(.failure(error))
                })
            })
        }
        loadNextProfileOrFinish()
    }
}
