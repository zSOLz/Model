//
//  LoginViewController.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {
    private let loginInteractor: LoginInteractor
    private let keyboardObserver = KeyboardHeightObserver()

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var keyboardConstraint: NSLayoutConstraint!
    
    var loginSucceededClosure: (UserAuthData) -> Void = { _ in }
    var openRegistrationClosure: () -> Void = {}
    
    init(loginInteractor: LoginInteractor) {
        self.loginInteractor = loginInteractor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupContent() {
        super.setupContent()
        
        title = "Login"
        
        keyboardObserver.heightChangedClosure = { [weak self] height in
            self?.keyboardConstraint.constant = height
            UIView.animate(withDuration: .standart) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
        
        refreshLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        loginInteractor.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: { [weak self] result in
            guard let self = self else { return }
            result.on(success: self.loginSucceededClosure, failure: self.errorClosure)
        })
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        openRegistrationClosure()
    }
    
    @IBAction func didChangeText(_ sender: Any) {
        refreshLoginButton()
    }
}

extension LoginViewController {
    private func refreshLoginButton() {
        loginButton.isEnabled = loginInteractor.isValidEmail(emailTextField.text ?? "") && loginInteractor.isValidPassword(passwordTextField.text ?? "")
    }
}
