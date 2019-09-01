//
//  RegistrationCredentialsViewController.swift
//  Model-Sample
//
//  Created by SOL on 09.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

final class RegistrationCredentialsViewController: PresentableViewController {
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var repeatPasswordTextField: UITextField!
    @IBOutlet var repeatPasswordErrorLabel: UILabel!
    @IBOutlet var activityIndicatorView: UIView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var submitButtonBottomConstraint: NSLayoutConstraint!
    
    fileprivate let keyboardObserver = KeyboardHeightObserver()

    @IBAction func submitButtonTapped(_ sender: Any) {
        presenter?.submitButtonTapped()
    }
    
    @IBAction func usernameTextChanged(_ sender: Any) {
        presenter?.usernameChanged(usernameTextField.text ?? "")
    }
    
    @IBAction func passwordTextChanged(_ sender: Any) {
        presenter?.passwordChanged(passwordTextField.text ?? "")
    }
    
    @IBAction func repeatPasswordTextChanged(_ sender: Any) {
        presenter?.repeatPasswordChanged(repeatPasswordTextField.text ?? "")
    }
}

// MARK: - Fileprivate
fileprivate extension RegistrationCredentialsViewController {
    final var presenter: RegistrationCredentialsPresenterInterface? {
        return presenterInterface as? RegistrationCredentialsPresenterInterface
    }
}

// MARK: - RegistrationCredentialsViewInterface
extension RegistrationCredentialsViewController: RegistrationCredentialsViewInterface {
    func setSubmitButton(enabled isEnabled: Bool) {
        submitButton.isEnabled = isEnabled
    }
    
    func setSetRepeatPasswordError(hidden isHidden: Bool) {
        repeatPasswordErrorLabel.isHidden = isHidden
    }
    
    func setActivityIndicator(visible: Bool) {
        if visible {
            activityIndicatorView.alpha = 0
            view.addSubview(activityIndicatorView)
            activityIndicatorView.frame = view.bounds
            UIView.animate(withDuration: .standart) { [weak self] in
                self?.activityIndicatorView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: .standart, animations: { [weak self] in
                self?.activityIndicatorView.alpha = 0
            }, completion: { [weak self] isCompleted in
                self?.activityIndicatorView.removeFromSuperview()
            })
        }
        navigationController?.setNavigationBarHidden(visible, animated: true)
    }
    
    func stopEditing() {
        view.endEditing(true)
    }
}

// MARK: - ContentContainerInterface
extension RegistrationCredentialsViewController {
    override func setupContent() {
        super.setupContent()
        
        title = "Registration: Credentials"
        
        keyboardObserver.heightChangedClosure = { [weak self] height in
            self?.submitButtonBottomConstraint.constant = height
            UIView.animate(withDuration: .standart) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
}
