//
//  UserProfilePresenter.swift
//  Model-Sample
//
//  Created by SOL on 09.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class UserProfilePresenter: Presenter {
    fileprivate let userProfileInteractor: UserProfileInteractorInterface
    
    init(router: ProfileRouterInterface, userProfileInteractor: UserProfileInteractorInterface) {
        self.userProfileInteractor = userProfileInteractor
        
        super.init(router: router)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated: animated)
        
        let viewModel = UserProfileViewModel(username: userProfileInteractor.username ?? "",
                                             email: userProfileInteractor.email ?? "",
                                             token: userProfileInteractor.token ?? "")
        view?.setup(viewModel: viewModel)
    }
}

// MARK: - Fileprivate
fileprivate extension UserProfilePresenter {
    final var view: UserProfileViewInterface? {
        return viewInterface as? UserProfileViewInterface
    }
    
    final var router: ProfileRouterInterface? {
        return routerInterface as? ProfileRouterInterface
    }
}

// MARK: - UserProfilePresenterInterface
extension UserProfilePresenter: UserProfilePresenterInterface {
    func logoutButtonTapped() {
        userProfileInteractor.logoutUser()
        router?.showUserWelcomeScreen()
    }
}
