//
//  UsersAPIManager.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/19/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Foundation

final class UsersAPIManager {
    let token: String
    init(token: String) {
        self.token = token
    }

    func friends(completion: @escaping (Result<[UserProfile], Error>) -> Void) {
        // Simulate internet delay
        // httpDataSource.get(endpoint: "friends", completion: ... )

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            completion(Backend.friends(token: self.token))
        }
    }
    
    func friends(profileId: UserProfile.Id, completion: @escaping (Result<[UserProfile], Error>) -> Void) {
        // Simulate internet delay
        // httpDataSource.get(endpoint: "friends", completion: ... )

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            completion(Backend.friends(token: self.token, profileId: profileId))
        }
    }
    
    func userProfile(withId profileId: UserProfile.Id, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        // Simulate internet delay
        // httpDataSource.get(endpoint: "userProfile", completion: ... )

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            completion(Backend.profile(withId: profileId))
        }
    }
    
    func addFriend(withId profileId: UserProfile.Id, completion: @escaping (Result<Void, Error>) -> Void) {
        // Simulate internet delay
        // httpDataSource.get(endpoint: "addFriend", completion: ... )

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            completion(Backend.addFriend(token: self.token, profileId: profileId))
        }
    }
    
    func removeFriend(withId profileId: UserProfile.Id, completion: @escaping (Result<Void, Error>) -> Void) {
        // Simulate internet delay
        // httpDataSource.get(endpoint: "removeFriend", completion: ... )

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            completion(Backend.removeFriend(token: self.token, profileId: profileId))
        }
    }
}
