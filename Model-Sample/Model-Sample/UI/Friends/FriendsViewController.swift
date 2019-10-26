//
//  FriendsViewController.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/22/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

private let friendsCellReuseIdentifier = "friendsCellReuseIdentifier"

struct FriendViewModel {
    let profileId: UserProfile.Id
    let avatarURL: URL?
    let name: String
}

class FriendsViewController: ViewController {
    private let friendsInteractor: FriendsInteractor
    private var viewModels = [FriendViewModel]()
    
    @IBOutlet var tableView: UITableView!
    
    var openProfile: (UserProfile.Id) -> Void = { _ in }
    
    init(friendsInteractor: FriendsInteractor) {
        self.friendsInteractor = friendsInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadFriends()
    }
}

// MARK: - private
private extension FriendsViewController {
    func reloadFriends() {
        friendsInteractor.myFriends(completion: { [weak self] friendsResult in
            guard let self = self else { return }
            friendsResult.on(success: { friends in
                self.viewModels = friends.map {
                    FriendViewModel(profileId: $0.id,
                                    avatarURL: $0.avatarURL,
                                    name: $0.email)
                }.sorted(by: { $0.name < $1.name })
                self.tableView.reloadData()
            }, failure: self.errorClosure)
        })
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let dequedCell = tableView.dequeueReusableCell(withIdentifier: friendsCellReuseIdentifier) {
            cell = dequedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: friendsCellReuseIdentifier)
            cell.accessoryType = .disclosureIndicator
        }
        let viewModel = viewModels[indexPath.row]
        cell.imageView?.image = UIImage(contentsOfFile: viewModel.avatarURL?.absoluteString ?? "")
        cell.textLabel?.text = viewModel.name
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openProfile(viewModels[indexPath.row].profileId)
    }
}
