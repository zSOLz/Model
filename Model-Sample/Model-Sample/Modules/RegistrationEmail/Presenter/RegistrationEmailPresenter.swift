//
//  RegistrationEmailPresenter.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class RegistrationEmailPresenter: Presenter {
    fileprivate let registrationInteractor: RegistrationInteractorInterface
    fileprivate var emailText: String
    
    init(router: RegistrationRouterInterface, registrationInteractor: RegistrationInteractorInterface) {
        self.registrationInteractor = registrationInteractor
        emailText = registrationInteractor.email
            
        super.init(router: router)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated: animated)
        
        view?.setup(email: emailText)
        view?.setContinueButton(enabled: registrationInteractor.isValidEmail(emailText))
    }
}

// MARK: - Fileprivate
fileprivate extension RegistrationEmailPresenter {
    final var view: RegistrationEmailViewInterface? {
        return viewInterface as? RegistrationEmailViewInterface
    }
    
    final var router: RegistrationRouterInterface? {
        return routerInterface as? RegistrationRouterInterface
    }
}

// MARK: - RegistrationEmailPresenterInterface
extension RegistrationEmailPresenter: RegistrationEmailPresenterInterface {
    func continueButtonTapped() {
        registrationInteractor.email = emailText
        router?.showCredentialsScreen()
    }
    
    func cancelButonTapped() {
        router?.cancelRegistration()
    }
    
    func emailChanged(email: String) {
        emailText = email
        
        let isEmailValid = registrationInteractor.isValidEmail(email)
        view?.setContinueButton(enabled: isEmailValid)
    }
}
