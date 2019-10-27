//
//  RegistrationViewController.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

class RegistrationViewController: ViewController {
    private let registrationInteractor: RegistrationInteractor
    private let keyboardObserver = KeyboardHeightObserver()
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var keyboardConstraint: NSLayoutConstraint!
    
    var nextClosure: () -> Void = {}
    
    init(registrationInteractor: RegistrationInteractor) {
        self.registrationInteractor = registrationInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.becomeFirstResponder()
    }
    
    override func setupContent() {
        super.setupContent()
        
        emailTextField.text = registrationInteractor.email
        usernameTextField.text = registrationInteractor.username
        
        title = "Registration"
        
        keyboardObserver.heightChangedClosure = { [weak self] height in
            self?.keyboardConstraint.constant = height
            UIView.animate(withDuration: .standart) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
        
        refreshNextButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        avatarImageView.roundCornersWithMaximumRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func didTapNext(_ sender: Any) {
        guard registrationInteractor.isValidEmail(emailTextField.text ?? ""),
            registrationInteractor.isValidUsername(usernameTextField.text ?? "") else {
                return
        }
        registrationInteractor.email = emailTextField.text ?? ""
        registrationInteractor.username = usernameTextField.text ?? ""
        
        nextClosure()
    }
    
    @IBAction func didChangeText(_ sender: Any) {
        refreshNextButton()
    }
    
    @IBAction func didTapPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}

// MARK: - Private
private extension RegistrationViewController {
    private func refreshNextButton() {
        nextButton.isEnabled = (registrationInteractor.isValidEmail(emailTextField.text ?? "") &&
                                registrationInteractor.isValidUsername(usernameTextField.text ?? "") &&
                                registrationInteractor.avatar != nil)
    }
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage {
            registrationInteractor.avatar = image
            avatarImageView.image = image
        }
        dismiss(animated: true, completion: nil)
        refreshNextButton()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
