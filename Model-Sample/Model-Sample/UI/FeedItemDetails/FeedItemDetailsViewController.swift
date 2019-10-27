//
//  FeedItemDetailsViewController.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

private let feedItemSectioinIndex = 0
private let commentsSectionIndex = 1

class FeedItemDetailsViewController: ViewController {
    private let feedItemId: NewsFeedItem.Id
    private let usersInteractor: UsersInteractor
    private let newsFeedInteractor: NewsFeedInteractor
    
    private var viewModel: NewsFeedItemViewModel?
    
    var openProfileClosure: (UserProfile.Id) -> Void = { _ in }

    @IBOutlet var tableView: UITableView!

    init(feedItemId: NewsFeedItem.Id,
         usersInteractor: UsersInteractor,
         newsFeedInteractor: NewsFeedInteractor) {
        self.feedItemId = feedItemId
        self.usersInteractor = usersInteractor
        self.newsFeedInteractor = newsFeedInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadFeedItem()
    }
    
    override func setupContent() {
        super.setupContent()
        
        tableView.register(UINib(nibName: NewsFeedTableCell.identifier, bundle: nil),
                           forCellReuseIdentifier: NewsFeedTableCell.identifier)
    }
}

// MARK: - Private
private extension FeedItemDetailsViewController {
    func reloadFeedItem() {
        newsFeedInteractor.newsFeedItem(withId: feedItemId, completion: { [weak self] result in
            result.on(success: { feedItem in
                self?.usersInteractor.userProfile(withId: feedItem.authorId, completion: { profileResult in
                    profileResult.on(success: { profile in
                        self?.reloadFeedItem(feedItem: feedItem, profile: profile)
                    }, failure: self?.errorClosure)
                })
            }, failure: self?.errorClosure)
        })
    }
    
    func reloadFeedItem(feedItem: NewsFeedItem, profile: UserProfile) {
        viewModel = NewsFeedItemViewModel(itemId: feedItem.id,
                                          authorId: profile.id,
                                          authorAvatarURL: profile.avatarURL,
                                          authorName: profile.username,
                                          date: DateFormatter.common.string(from: feedItem.date),
                                          text: feedItem.text,
                                          imageURL: feedItem.imageURL)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension FeedItemDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case feedItemSectioinIndex:
            return viewModel == nil ? 0 : 1
        case commentsSectionIndex:
            return 0
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case feedItemSectioinIndex: return nil
        case commentsSectionIndex: return "Comments: (TODO)"
        default: return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case feedItemSectioinIndex:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableCell.identifier, for: indexPath) as! NewsFeedTableCell
            if let viewModel = viewModel {
                cell.setup(viewModel: viewModel)
                cell.tapUserNameClosure = { [weak self] in
                    self?.openProfileClosure(viewModel.authorId)
                }
            }
            return cell
        case commentsSectionIndex:
            fatalError("TODO: Comments")

        default:
            fatalError("Unexpected section index: \(indexPath.section)")
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
