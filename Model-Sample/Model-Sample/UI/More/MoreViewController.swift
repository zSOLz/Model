//
//  MoreViewController.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/23/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

private let openProfileSectionIndex = 0
private let logoutSectionIndex = 1
private let cellReuseIdentifier = "General"

class MoreViewController: ViewController {
    private let usersInteractor: UsersInteractor
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    @IBOutlet var tableView: UITableView!
    
    var openProfileClosure: (UserProfile.Id) -> Void = { _ in }
    var logoutClosure: () -> Void = {}

    init(usersInteractor: UsersInteractor) {
        self.usersInteractor = usersInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupContent() {
        super.setupContent()
        
        title = "More"
        avatarImageView.roundCornersWithMaximumRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadProfile()
    }
}

// MARK: - Private
private extension MoreViewController {
    func reloadProfile() {
        usersInteractor.myProfile(completion: { [weak self] result in
            guard let self = self else { return }
            result.on(success: { profile in
                self.avatarImageView.loadImage(url: profile.avatarURL)
                self.nameLabel.text = profile.username
            }, failure: self.errorClosure)
        })
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension MoreViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case openProfileSectionIndex:
            return 1
        case logoutSectionIndex:
            return 1
        default: return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let dequedCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) {
            cell = dequedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        }
        switch indexPath.section {
        case openProfileSectionIndex:
            cell.textLabel?.text = "Open profile"
            cell.textLabel?.textColor = UIColor.darkGray
            cell.accessoryType = .disclosureIndicator
        case logoutSectionIndex:
            cell.textLabel?.text = "Log out"
            cell.textLabel?.textColor = UIColor.red
            cell.accessoryType = .none
        default:
            break
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case openProfileSectionIndex:
            usersInteractor.myProfile(completion: { [weak self] result in
                guard let self = self else { return }
                result.map { $0.id }.on(success: { profileId in
                    self.openProfileClosure(profileId)
                }, failure: self.errorClosure)
            })
        case logoutSectionIndex:
            logoutClosure()
        default:
            break
        }
    }
}
