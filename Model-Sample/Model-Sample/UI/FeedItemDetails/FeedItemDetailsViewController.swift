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
    private let keyboardObserver = KeyboardHeightObserver()

    private var viewModel: NewsFeedItemViewModel?
    private var commentsViewModels: [FeedItemCommentViewModel] = []
    
    var openProfileClosure: (UserProfile.Id) -> Void = { _ in }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var placeholderLabel: UILabel!
    @IBOutlet var keyboardConstraint: NSLayoutConstraint!

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
        reloadComments(fromCache: true, completion: { [weak self] in
            self?.reloadComments(fromCache: false)
        })
    }
    
    override func setupContent() {
        super.setupContent()
        
        keyboardObserver.heightChangedClosure = { [weak self] height in
            self?.keyboardConstraint.constant = height
            UIView.animate(withDuration: .standart) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
        
        tableView.register(UINib(nibName: NewsFeedTableCell.identifier, bundle: nil),
                           forCellReuseIdentifier: NewsFeedTableCell.identifier)
        tableView.register(UINib(nibName: FeedItemCommentTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: FeedItemCommentTableViewCell.identifier)

        refreshSendButtonAndPlaceholder()
    }
    
    @IBAction func didTapAddComment() {
        let text = commentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else {
            return
        }
        newsFeedInteractor.addComment(feedItemId: feedItemId, text: text, completion: { [weak self] result in
            result.on(success: { _ in
                self?.commentTextView.text = ""
                self?.commentTextView.resignFirstResponder()
                self?.reloadComments(fromCache: true, animateReload: true)
            }, failure: self?.errorClosure)
        })
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
    
    func reloadComments(fromCache: Bool, animateReload: Bool = false, completion: (() -> Void)? = nil) {
        newsFeedInteractor.comments(useCache: fromCache, feedItemId: feedItemId, completion: { [weak self] result in
            result.on(success: { comments in
                let authorIds = Array(Set(comments.map { $0.authorId })) // Get unique user ids
                self?.usersInteractor.userProfiles(withId: authorIds, completion: { [weak self] usersResult in
                    usersResult.on(success: { profiles in
                        self?.reloadComments(comments: comments, profiles: profiles, animateReload: animateReload)
                    }, failure: self?.errorClosure)
                })
            }, failure: self?.errorClosure)
            completion?()
        })
    }
    
    func reloadComments(comments: [FeedItemComment], profiles: [UserProfile], animateReload: Bool) {
        let mappedProfiles = profiles.reduce(into: [UserProfile.Id: UserProfile](), { $0[$1.id] = $1 })
        let commentsViewModels: [FeedItemCommentViewModel] = comments.compactMap { comment in
            guard let profile = mappedProfiles[comment.authorId] else {
                assertionFailure("Unable to find author with id: \(comment.authorId)")
                return nil
            }
            return FeedItemCommentViewModel(authorId: profile.id,
                                            authorAvatarURL: profile.avatarURL,
                                            authorName: profile.username,
                                            date: DateFormatter.common.string(from: comment.date),
                                            text: comment.text)
        }
        self.commentsViewModels = commentsViewModels
        if animateReload {
            tableView.reloadSections([commentsSectionIndex], with: .fade)
        } else {
            tableView.reloadData()
        }
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
    
    func refreshSendButtonAndPlaceholder() {
        placeholderLabel.isHidden = !commentTextView.text.isEmpty
        let text = commentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        sendButton.isEnabled = !text.isEmpty
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
            return commentsViewModels.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case feedItemSectioinIndex: return nil
        case commentsSectionIndex: return commentsViewModels.isEmpty ? nil : "Comments"
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
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedItemCommentTableViewCell.identifier, for: indexPath) as! FeedItemCommentTableViewCell
            let viewModel = commentsViewModels[indexPath.row]
            cell.setup(viewModel: viewModel)
            cell.tapUserNameClosure = { [weak self] in
                self?.openProfileClosure(viewModel.authorId)
            }
            return cell

        default:
            fatalError("Unexpected section index: \(indexPath.section)")
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FeedItemDetailsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        refreshSendButtonAndPlaceholder()
    }
}
