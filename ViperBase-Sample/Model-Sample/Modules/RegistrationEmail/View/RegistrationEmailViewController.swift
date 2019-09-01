//
//  RegistrationEmailViewController.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

final class RegistrationEmailViewController: PresentableViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var continueButtonBottomConstraint: NSLayoutConstraint!
    
    fileprivate let keyboardObserver = KeyboardHeightObserver()
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        presenter?.continueButtonTapped()
    }
    
    @IBAction func emailTextChanged(_ sender: Any) {
        presenter?.emailChanged(email: emailTextField.text ?? "")
    }
    
    @objc func cancelButonTapped(_ sender: Any) {
        presenter?.cancelButonTapped()
    }
}

// MARK: - Fileprivate
fileprivate extension RegistrationEmailViewController {
    final var presenter: RegistrationEmailPresenterInterface? {
        return presenterInterface as? RegistrationEmailPresenterInterface
    }
}

// MARK: - RegistrationEmailViewInterface
extension RegistrationEmailViewController: RegistrationEmailViewInterface {
    func setup(email: String) {
        emailTextField.text = email
    }
    
    func setContinueButton(enabled isEnabled: Bool) {
        continueButton.isEnabled = isEnabled
    }
}

// MARK: - ContentContainerInterface
extension RegistrationEmailViewController {
    override func setupContent() {
        super.setupContent()
        
        title = "Registration: Email"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                            target: self,
                                                            action: #selector(RegistrationEmailViewController.cancelButonTapped(_:)))
        
        keyboardObserver.heightChangedClosure = { [weak self] height in
            self?.continueButtonBottomConstraint.constant = height
            UIView.animate(withDuration: .standart) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
}
