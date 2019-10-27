//
//  UsersAssembly.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/24/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class ProfileAssembly: Assembly {
    static func makeUsersCache() -> UsersCache {
        return UsersCache()
    }
    
    static func makeMoreCoordinator(parent: Coordinator) -> MoreCoordinator {
        return MoreCoordinator(parent: parent)
    }
    
    static func makeFriendCoordinator(parent: Coordinator) -> FriendsCoordinator {
        return FriendsCoordinator(parent: parent)
    }

    static func makeUsersInteractor(resolver: Resolver) -> UsersInteractor {
        let userDataSession = resolver.resolve(UserDataSession.self)
        return UsersInteractor(usersApiManager: UsersAPIManager(token: userDataSession.authenticationToken),
                               userDataSession: userDataSession,
                               usersCache: resolver.resolve(UsersCache.self))
    }
    
    static func makeFriendsInteractor(resolver: Resolver) -> FriendsInteractor {
        let token = resolver.resolve(UserDataSession.self).authenticationToken
        return FriendsInteractor(usersApiManager: UsersAPIManager(token: token),
                                 usersCache: resolver.resolve(UsersCache.self))
    }

    static func makeMyFriendsViewController(resolver: Resolver) -> FriendsViewController {
        let friendsIntaractor = makeFriendsInteractor(resolver: resolver)
        let friendsViewController = FriendsViewController(profileId: nil, friendsInteractor: friendsIntaractor)
        return friendsViewController
    }
    
    static func makeFriendsViewController(profileId: UserProfile.Id, resolver: Resolver) -> FriendsViewController {
        let friendsIntaractor = makeFriendsInteractor(resolver: resolver)
        let friendsViewController = FriendsViewController(profileId: profileId, friendsInteractor: friendsIntaractor)
        return friendsViewController
    }

    static func makeUserProfileViewController(profileId: UserProfile.Id, resolver: Resolver) -> UserProfileViewController {
        let usersInteractor = makeUsersInteractor(resolver: resolver)
        let newsFeedInteractor = NewsFeedAssembly.makeNewsFeedInteractor(resolver: resolver)
        let friendsInteractor = makeFriendsInteractor(resolver: resolver)

        let userProfileViewController = UserProfileViewController(profileId: profileId,
                                                                  usersInteractor: usersInteractor,
                                                                  newsFeedInteractor: newsFeedInteractor,
                                                                  friendsInteractor: friendsInteractor)
        return userProfileViewController
    }
    
    static func makeMoreViewController(resolver: Resolver) -> MoreViewController {
        let usersInteractor = makeUsersInteractor(resolver: resolver)
        let moreViewController = MoreViewController(usersInteractor: usersInteractor)
        return moreViewController
    }
}

extension UsersCache: Resolvable {}
