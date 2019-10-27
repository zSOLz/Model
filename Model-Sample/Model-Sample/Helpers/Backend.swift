//
//  Backend.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

class Backend {
    private init() {}
    
    static func registerUser(registrationInfo: UserRegistrationData) -> Result<UserAuthData, Error> {
        if let _ = users.first(where: { $0.email == registrationInfo.email }) {
            return .failure(GenericError.accountDuplication)
        }
        
        let token = UUID().uuidString // Get random token string as server response
        let userProfile = UserProfile(id: UUID().uuidString, // Get random user id
                                      username: registrationInfo.username,
                                      email: registrationInfo.email,
                                      avatarURL: ImagesDataSource.store(image: registrationInfo.avatar))
                
        users.append(userProfile)
        tokens[token] = userProfile.id

        let userIds = users.map { $0.id }
        let ransomFriendsIds = Set(userIds.indices.compactMap { _ in userIds.randomElement() })
        ransomFriendsIds.forEach {
            _ = addFriend(profileId1: $0, profileId2: userProfile.id)
        }

        return .success(UserAuthData(profile: userProfile, token: token))
    }
    
    static func loginUser(email: String, password: String) -> Result<UserAuthData, Error> {
        guard let profile = users.first(where: { $0.email == email }) else {
            return .failure(GenericError.userNotFound)
        }
        // Do not check password - This is just a demo
        
        let token = UUID().uuidString
        tokens[token] = profile.id
        
        return .success(UserAuthData(profile: profile, token: token))
    }

    static func friends(token: String) -> Result<[UserProfile], Error> {
        guard let userId = tokens[token] else {
            return .failure(GenericError.notAuthorized)
        }
        let friendsIds = Array(friends[userId] ?? [])
        let userFriends = users.filter { friendsIds.contains($0.id) }
        return .success(userFriends)
    }
    
    static func friends(token: String, profileId: UserProfile.Id) -> Result<[UserProfile], Error> {
        guard let _ = tokens[token] else {
            return .failure(GenericError.notAuthorized)
        }
        let friendsIds = Array(friends[profileId] ?? [])
        let userFriends = users.filter { friendsIds.contains($0.id) }
        return .success(userFriends)
    }
    
    static func newsFeed(token: String) -> Result<[NewsFeedItem], Error> {
        guard let userId = tokens[token] else {
            return .failure(GenericError.notAuthorized)
        }
        
        var friendsIds = friends[userId] ?? []
        friendsIds.insert(userId)
        let newsFeed = feedItems.filter { friendsIds.contains($0.authorId) }
        return .success(newsFeed)
    }
    
    static func feed(profileId: String) -> Result<[NewsFeedItem], Error> {
        guard hasUser(withId: profileId) else {
            return .failure(GenericError.userNotFound)
        }
        
        let feed = feedItems.filter { $0.authorId == profileId }
        return .success(feed)
    }
    
    static func addItem(token: String, text: String?, image: UIImage?) -> Result<NewsFeedItem, Error> {
        guard text != nil || image != nil else {
            return .failure(GenericError.invalidParameters)
        }
        guard let userId = tokens[token] else {
            return .failure(GenericError.notAuthorized)
        }
        
        let imageUrl: URL?
        if let image = image {
            imageUrl = ImagesDataSource.store(image: image)
        } else {
            imageUrl = nil
        }
        let feedItem = NewsFeedItem(id: UUID().uuidString,
                                    date: Date(),
                                    authorId: userId,
                                    text: text,
                                    imageURL: imageUrl,
                                    isLiked: false)
        feedItems.insert(feedItem, at: 0)
        
        return .success(feedItem)
    }
    
    static func profile(withId profileId: UserProfile.Id) -> Result<UserProfile, Error> {
        guard let profile = users.first(where: { $0.id == profileId }) else {
            return .failure(GenericError.userNotFound)
        }
        return .success(profile)
    }
    
    static func newsFeedItem(withId itemId: NewsFeedItem.Id) -> Result<NewsFeedItem, Error> {
        guard let item = feedItems.first(where: { $0.id == itemId }) else {
            return .failure(GenericError.noResultForParameter)
        }
        return .success(item)
    }
    
    static func addFriend(token: String, profileId: UserProfile.Id) -> Result<Void, Error> {
        guard let userId = tokens[token] else {
            return .failure(GenericError.notAuthorized)
        }
        return addFriend(profileId1: userId, profileId2: profileId)
    }
    
    static func removeFriend(token: String, profileId: UserProfile.Id) -> Result<Void, Error> {
        guard let userId = tokens[token] else {
            return .failure(GenericError.notAuthorized)
        }
        return removeFriend(profileId1: userId, profileId2: profileId)
    }
}

// MARK: - Private
private extension Backend {
    static func addFriend(profileId1: UserProfile.Id, profileId2: UserProfile.Id) -> Result<Void, Error> {
        guard hasUser(withId: profileId1), hasUser(withId: profileId2) else {
            return .failure(GenericError.userNotFound)
        }
            
        friends[profileId1, default: []].insert(profileId2)
        friends[profileId2, default: []].insert(profileId1)
        return .success(())
    }
    
    static func removeFriend(profileId1: UserProfile.Id, profileId2: UserProfile.Id) -> Result<Void, Error> {
        guard hasUser(withId: profileId1), hasUser(withId: profileId2) else {
            return .failure(GenericError.userNotFound)
        }
            
        friends[profileId1, default: []].remove(profileId2)
        friends[profileId2, default: []].remove(profileId1)
        return .success(())
    }
    
    static func hasUser(withId userId: UserProfile.Id) -> Bool {
        return users.contains(where: { $0.id == userId })
    }
}

// MARK: - Data
private extension Backend {
    static var tokens = [String: UserProfile.Id]()
        
    static var users: [UserProfile] = {
        var profiles = [UserProfile]()
        
        profiles.append(UserProfile(id: "author-1",
                                    username: "John Doe",
                                    email: "john@mail.com",
                                    avatarURL: nil))
        
        profiles.append(UserProfile(id: "author-2",
                                    username: "Adam Savage",
                                    email: "adam@mail.com",
                                    avatarURL: nil))
        
        profiles.append(UserProfile(id: "author-3",
                                    username: "Jimi Hendrix",
                                    email: "jimi@mail.com",
                                    avatarURL: nil))
        
        profiles.append(UserProfile(id: "author-4",
                                    username: "David Bowee",
                                    email: "david@mail.com",
                                    avatarURL: nil))

        return profiles
    }()
    
    static var friends: [UserProfile.Id: Set<UserProfile.Id>] = ["author-1" : ["author-2"],
                                                                 "author-2": ["author-1", "author-3", "author-4"],
                                                                 "author-3": ["author-2", "author-4"],
                                                                 "author-4": ["author-2", "author-3"]]
    static var feedItems: [NewsFeedItem] = {
        var feedItems = [NewsFeedItem]()
        
        feedItems.append(NewsFeedItem(id: "1",
                                      date: Date(timeIntervalSinceNow: -(.day * 2)),
                                      authorId: "author-1",
                                      text: "Without new economic projections today or a press conferece, there's no shot the Fed raises rates. Instead, look to the policy statement to be the catalyst for price action.",
                                      imageURL: ImagesDataSource.store(imageName: "finance-1"),
                                      isLiked: true))
        
        feedItems.append(NewsFeedItem(id: "2",
                                      date: Date(timeIntervalSinceNow: -(.day * 5 - .minute * 30)),
                                      authorId: "author-2",
                                      text: "Today, we started off by looking at the US Dollar Index (DXY) ahead of the FOMC rate decision and policy statement later today. No expectation of a move out of the Fed, so traders will focus on the language in the statement for clues as to future moves.",
                                      imageURL: ImagesDataSource.store(imageName: "finance-2"),
                                      isLiked: false))
        
        feedItems.append(NewsFeedItem(id: "3",
                                      date: Date(timeIntervalSinceNow: -(.day * 8 - .minute * 10)),
                                      authorId: "author-2",
                                      text: "Eurozone GDP figures headline the economic calendar in European trading hours. The on-year growth rate is expected to register at 1.7 percent in the first quarter, unchanged from the three months through December 2016. The quarterly gain is projected at 0.5 percent, also a repeat of the prior period.",
                                      imageURL: nil,
                                      isLiked: false))
        
        feedItems.append(NewsFeedItem(id: "4",
                                      date: Date(timeIntervalSinceNow: -(.day * 10 - .minute * 34)),
                                      authorId: "author-3",
                                      text: "Pass item ID to router and then build correct controller with correct parameters.\n\n" +
                                            "See call stack:\nNewsFeedViewController.tableView(_:didSelectRowAt:)\n" +
                                            "NewsFeedPresenterInterface.articleTapped(at:)\n" +
                                            "NewsFeedRouter.showArticleDetails(with:)\n" +
                                            "NewsFeedAssembly.articleDetailsViewController(withArticleId:)",
                                      imageURL: ImagesDataSource.store(imageName: "arhitecture-1"),
                                      isLiked: false))
        
        feedItems.append(NewsFeedItem(id: "5",
                                      date: Date(timeIntervalSinceNow: -(.day * 14 - .minute * 30)),
                                      authorId: "author-1",
                                      text: "Woody equal ask saw sir weeks aware decay. Entrance prospect removing we packages strictly is no smallest he. For hopes may chief get hours day rooms. Oh no turned behind polite piqued enough at. Forbade few through inquiry blushes you.",
                                      imageURL: nil,
                                      isLiked: false))
        
        feedItems.append(NewsFeedItem(id: "6",
                                      date: Date(timeIntervalSinceNow: -(.day * 20 - .minute * 16)),
                                      authorId: "author-2",
                                      text: "Swift’s grand entrance to the programming world at WWDC in 2014 was much more than just an introduction of a new language. It brought a number of new approaches to software development for the iOS and macOS platforms.",
                                      imageURL: ImagesDataSource.store(imageName: "arhitecture-2"),
                                      isLiked: true))
        
        return feedItems
    }()
}
