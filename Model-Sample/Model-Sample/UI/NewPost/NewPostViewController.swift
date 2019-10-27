//
//  NewPostViewController.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/27/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

class NewPostViewController: ViewController {
    private let newsFeedInteractor: NewsFeedInteractor
    private let keyboardObserver = KeyboardHeightObserver()
    
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var keyboardConstraint: NSLayoutConstraint!
    
    private var doneButton: UIBarButtonItem!
    private var cancelButton: UIBarButtonItem!

    var closeClosure: () -> Void = {}
    
    init(newsFeedInteractor: NewsFeedInteractor) {
        self.newsFeedInteractor = newsFeedInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupContent() {
        super.setupContent()
        
        title = "Say something"
        
        keyboardObserver.heightChangedClosure = { [weak self] height in
            self?.keyboardConstraint.constant = height
            UIView.animate(withDuration: .standart) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
        
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone(_:)))
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton

        refreshDoneButton()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageTextView.becomeFirstResponder()
    }
}

// MARK: - Private
private extension NewPostViewController {
    private func refreshDoneButton() {
        doneButton.isEnabled = !messageTextView.text.isEmpty
    }
    
    @objc func didTapDone(_ sender: Any) {
        guard !messageTextView.text.isEmpty else {
            return
        }
        newsFeedInteractor.addItem(text: messageTextView.text, image: nil, completion: { [weak self] result in
            result.on(success: { _ in
                self?.closeClosure()
            }, failure: self?.errorClosure)
        })
    }
    
    @objc func didTapClose(_ sender: Any) {
        closeClosure()
    }
}

extension NewPostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        refreshDoneButton()
    }
}
