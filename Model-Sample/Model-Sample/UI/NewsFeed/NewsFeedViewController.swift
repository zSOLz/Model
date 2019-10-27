//
//  NewsFeedViewController.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

private let articleCellEstimatedHeight: CGFloat = 144

final class NewsFeedViewController: ViewController {
    private let newsFeedInteractor: NewsFeedInteractor
    private let usersInteractor: UsersInteractor
    
    private var viewModels = [NewsFeedItemViewModel]()

    @IBOutlet var tableView: UITableView!
    
    var openFeedItemClosure: (NewsFeedItem.Id) -> Void = { _ in }
    var openProfileClosure: (UserProfile.Id) -> Void = { _ in }
    var newPostClosure: () -> Void = {}

    init(newsFeedInteractor: NewsFeedInteractor,
         usersInteractor: UsersInteractor) {
        self.newsFeedInteractor = newsFeedInteractor
        self.usersInteractor = usersInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupContent() {
        super.setupContent()
        
        tableView.register(UINib(nibName: NewsFeedTableCell.identifier, bundle: nil),
                           forCellReuseIdentifier: NewsFeedTableCell.identifier)
        
        tableView.estimatedRowHeight = articleCellEstimatedHeight
        tableView.rowHeight = UITableView.automaticDimension
        title = "News"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadNewsFeed()
    }
    
    @IBAction func didTapAddPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func didTapNewPost(_ sender: Any) {
        newPostClosure()
    }
}

// MARK: - Private
private extension NewsFeedViewController {
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
                                         authorId: profile.id,
                                         authorAvatarURL: profile.avatarURL,
                                         authorName: profile.username,
                                         date: DateFormatter.common.string(from: feedItem.date),
                                         text: feedItem.text,
                                         imageURL: feedItem.imageURL)
        }
        self.viewModels = feedViewModels
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension NewsFeedViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableCell.identifier, for: indexPath) as! NewsFeedTableCell
        let viewModel = viewModels[indexPath.row]
        cell.setup(viewModel: viewModel)
        cell.tapUserNameClosure = { [weak self] in
            self?.openProfileClosure(viewModel.authorId)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openFeedItemClosure(viewModels[indexPath.row].itemId)
    }
}

extension NewsFeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage {
            newsFeedInteractor.addItem(text: nil, image: image, completion: { [weak self] result in
                result.on(success: { _ in
                    self?.reloadNewsFeed()
                }, failure: self?.errorClosure)
            })
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
