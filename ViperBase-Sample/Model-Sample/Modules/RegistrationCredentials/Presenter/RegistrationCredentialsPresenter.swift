//
//  RegistrationCredentialsPresenter.swift
//  Model-Sample
//
//  Created by SOL on 09.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class RegistrationCredentialsPresenter: Presenter {
    fileprivate let registrationInteractor: RegistrationInteractorInterface
    fileprivate var usernameText: String = ""
    fileprivate var passwordText: String = ""
    fileprivate var repeatPasswordText: String = ""
    
    init(router: RegistrationRouterInterface, registrationInteractor: RegistrationInteractorInterface) {
        self.registrationInteractor = registrationInteractor
        
        super.init(router: router)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated: animated)
        
        hideRepeatPasswordError()
        updateSubmitButtonState()
    }
}

// MARK: - Fileprivate
fileprivate extension RegistrationCredentialsPresenter {
    final var view: RegistrationCredentialsViewInterface? {
        return viewInterface as? RegistrationCredentialsViewInterface
    }
    
    final var router: RegistrationRouterInterface? {
        return routerInterface as? RegistrationRouterInterface
    }
    
    var isAllFieldsValid: Bool {
        let isValidUsername = registrationInteractor.isValidUsername(usernameText)
        let isValidPassword = registrationInteractor.isValidPassword(passwordText)
        let isValidRepeatPassword = registrationInteractor.isValidPassword(repeatPasswordText)
        
        return (isValidUsername && isValidPassword && isValidRepeatPassword)
    }
    
    func updateSubmitButtonState() {
        view?.setSubmitButton(enabled: isAllFieldsValid)
    }
    
    func hideRepeatPasswordError() {
        view?.setSetRepeatPasswordError(hidden: true)
    }
}

// MARK: - RegistrationCredentialsPresenterInterface
extension RegistrationCredentialsPresenter: RegistrationCredentialsPresenterInterface {
    func submitButtonTapped() {
        view?.stopEditing()
        
        guard passwordText == repeatPasswordText else {
            view?.setSetRepeatPasswordError(hidden: false)
            return
        }
        
        guard isAllFieldsValid else {
            assertionFailure("Unexpected state: not all credentials fields passed validation successfully")
            return
        }

        view?.setActivityIndicator(visible: true)

        registrationInteractor.username = usernameText
        registrationInteractor.password = passwordText
        registrationInteractor.registerUser(success: { [weak self] in
            self?.router?.completeRegistration()
        }, failure: { [weak self] error in
            self?.view?.setActivityIndicator(visible: false)
            // TODO: Show alert
        })
    }
    
    func usernameChanged(_ username: String) {
        usernameText = username
        updateSubmitButtonState()
        hideRepeatPasswordError()
    }
    
    func passwordChanged(_ password: String) {
        passwordText = password
        updateSubmitButtonState()
        hideRepeatPasswordError()
    }
    
    func repeatPasswordChanged(_ repeatPassword: String) {
        repeatPasswordText = repeatPassword
        updateSubmitButtonState()
        hideRepeatPasswordError()
    }
}
