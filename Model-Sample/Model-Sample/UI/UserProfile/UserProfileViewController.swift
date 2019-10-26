//
//  UserProfileViewController.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

private let friendsSectionIndex = 0
private let postsSectionIndex = 1
private let friendsCellReuseIdentifier = "friendsCellReuseIdentifier"

class UserProfileViewController: ViewController {
    private let profileId: UserProfile.Id
    private let usersInteractor: UsersInteractor
    private let newsFeedInteractor: NewsFeedInteractor
    private let friendsInteractor: FriendsInteractor
    
    private var viewModels = [NewsFeedItemViewModel]()
    private var numberOfFriendsViewModel: Int?

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!

    @IBOutlet var tableView: UITableView!
    
    var openFeedItemClosure: (NewsFeedItem.Id) -> Void = { _ in }
    var openFriendsList: (UserProfile.Id) -> Void = { _ in }

    init(profileId: UserProfile.Id,
         usersInteractor: UsersInteractor,
         newsFeedInteractor: NewsFeedInteractor,
         friendsInteractor: FriendsInteractor) {
        self.profileId = profileId
        self.usersInteractor = usersInteractor
        self.newsFeedInteractor = newsFeedInteractor
        self.friendsInteractor = friendsInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadProfile()
        reloadNewsFeed()
        reloadFriends()
    }
    
    override func setupContent() {
        super.setupContent()
        
        avatarImageView.roundCornersWithMaximumRadius()
    }
}

// MARK: - private
private extension UserProfileViewController {
    func reloadFriends() {
        friendsInteractor.friends(forProfileId: profileId, completion: { [weak self] result in
            guard let self = self else { return }
            result.map { $0.count }.on(success: { count in
                self.numberOfFriendsViewModel = count
                self.tableView.reloadSections([friendsSectionIndex], with: .none)
            }, failure: self.errorClosure)
        })
    }
    
    func reloadProfile() {
        usersInteractor.userProfile(withId: profileId, completion: { [weak self] result in
            guard let self = self else { return }
            result.on(success: { profile in
                self.avatarImageView.image = UIImage(contentsOfFile: profile.avatarURL?.absoluteString ?? "")
                self.emailLabel.text = profile.email
                self.nameLabel.text = profile.username
            }, failure: self.errorClosure)
        })
    }

    func reloadNewsFeed() {
        newsFeedInteractor.myNewsFeed(completion: { [weak self] newsFeedResult in
            newsFeedResult.on(success: { feedItems in
                let authorIds = Array(Set(feedItems.map { $0.authorId })) // Get unique user ids
                self?.usersInteractor.userProfiles(withId: authorIds, completion: { [weak self] usersResult in
                    usersResult.on(success: { profiles in
                        self?.reloadNewsFeed(feedItems: feedItems, profiles: profiles)
                    }, failure: self?.errorClosure)
                })
            }, failure: self?.errorClosure)
        })
    }
    
    func reloadNewsFeed(feedItems: [NewsFeedItem], profiles: [UserProfile]) {
        let mappedProfiles = profiles.reduce(into: [UserProfile.Id: UserProfile](), { $0[$1.id] = $1 })
        let feedViewModels: [NewsFeedItemViewModel] = feedItems.compactMap { feedItem in
            guard let profile = mappedProfiles[feedItem.authorId] else {
                assertionFailure("Unable to find author with id: \(feedItem.authorId)")
                return nil
            }
            return NewsFeedItemViewModel(itemId: feedItem.id,
                                         authorAvatarURL: profile.avatarURL,
                                         authorName: profile.username,
                                         date: DateFormatter().string(from: feedItem.date),
                                         text: feedItem.text,
                                         imageURL: feedItem.imageURL)
        }
        self.viewModels = feedViewModels
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case friendsSectionIndex:
            return numberOfFriendsViewModel == nil ? 0 : 1
        case postsSectionIndex:
            return viewModels.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case friendsSectionIndex: return nil
        case postsSectionIndex: return "Feed"
        default: return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case friendsSectionIndex:
            let cell: UITableViewCell
            if let dequedCell = tableView.dequeueReusableCell(withIdentifier: friendsCellReuseIdentifier) {
                cell = dequedCell
            } else {
                cell = UITableViewCell(style: .default, reuseIdentifier: friendsCellReuseIdentifier)
                cell.accessoryType = .disclosureIndicator
            }
            if let numberOfFriendsViewModel = numberOfFriendsViewModel {
                cell.textLabel?.text = "All friends \(numberOfFriendsViewModel)"
            } else {
                cell.textLabel?.text = nil
            }
            return cell
        case postsSectionIndex:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableCell.identifier, for: indexPath) as! NewsFeedTableCell
            cell.setup(viewModel: viewModels[indexPath.row])
            return cell

        default:
            fatalError("Unexpected section index: \(indexPath.section)")
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case friendsSectionIndex:
            openFriendsList(profileId)
        case postsSectionIndex:
            openFeedItemClosure(viewModels[indexPath.row].itemId)
        default:
            break
        }
    }
}
