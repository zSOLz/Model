//
//  FriendsViewController.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/22/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

struct FriendViewModel {
    let profileId: UserProfile.Id
    let avatarURL: URL?
    let name: String
}

class FriendsViewController: ViewController {
    private let profileId: UserProfile.Id?
    private let friendsInteractor: FriendsInteractor
    private var viewModels = [FriendViewModel]()
    
    @IBOutlet var tableView: UITableView!
    
    var openProfileClosure: (UserProfile.Id) -> Void = { _ in }
    
    init(profileId: UserProfile.Id?,
         friendsInteractor: FriendsInteractor) {
        self.profileId = profileId
        self.friendsInteractor = friendsInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupContent() {
        super.setupContent()
        
        title = "Friends"
        
        tableView.register(UINib(nibName: FriendTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: FriendTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadFriends()
    }
}

// MARK: - Private
private extension FriendsViewController {
    func reloadFriends() {
        let completionClosure: (Result<[UserProfile], Error>) -> Void = { [weak self] friendsResult in
            guard let self = self else { return }
            friendsResult.on(success: { friends in
                self.viewModels = friends.map {
                    FriendViewModel(profileId: $0.id,
                                    avatarURL: $0.avatarURL,
                                    name: $0.email)
                }.sorted(by: { $0.name < $1.name })
                self.tableView.reloadData()
            }, failure: self.errorClosure)
        }
        
        if let profileId = profileId {
            friendsInteractor.friends(forProfileId: profileId, completion: completionClosure)
        } else {
            friendsInteractor.myFriends(completion: completionClosure)
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as! FriendTableViewCell
        let viewModel = viewModels[indexPath.row]
        cell.avatarImageView.loadImage(url: viewModel.avatarURL)
        cell.avatarImageView.roundCornersWithMaximumRadius()
        cell.nameLabel?.text = viewModel.name
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openProfileClosure(viewModels[indexPath.row].profileId)
    }
}
