//
//  PasswordViewController.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

class PasswordViewController: ViewController {
    private let registrationInteractor: RegistrationInteractor
    private let keyboardObserver = KeyboardHeightObserver()
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var regsiterButton: UIButton!
    @IBOutlet var keyboardConstraint: NSLayoutConstraint!
    
    var registrationSucceededClosure: (UserAuthData) -> Void = { _ in }
    
    init(registrationInteractor: RegistrationInteractor) {
        self.registrationInteractor = registrationInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.becomeFirstResponder()
    }
    
    override func setupContent() {
        super.setupContent()
        
        passwordTextField.text = registrationInteractor.password
        confirmPasswordTextField.text = nil
        
        title = "Registration"
        
        keyboardObserver.heightChangedClosure = { [weak self] height in
            self?.keyboardConstraint.constant = height
            UIView.animate(withDuration: .standart) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
        
        refreshRegisterButton()
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        guard isPasswordInputValid else {
            return
        }
        registrationInteractor.password = passwordTextField.text ?? ""
        
        registrationInteractor.registerUser(completion: { [weak self] result in
            guard let self = self else { return }
            result.on(success: self.registrationSucceededClosure, failure: self.errorClosure)
        })
    }
    
    @IBAction func didChangeText(_ sender: Any) {
        refreshRegisterButton()
    }
}

// MARK: - Private
private extension PasswordViewController {
    private func refreshRegisterButton() {
        regsiterButton.isEnabled = isPasswordInputValid
    }
    
    private var isPasswordInputValid: Bool {
        return registrationInteractor.isValidPassword(passwordTextField.text ?? "") &&
            passwordTextField.text == confirmPasswordTextField.text
    }
}
