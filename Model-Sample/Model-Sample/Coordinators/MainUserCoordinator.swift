//
//  MainUserCoordinator.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/24/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class MainUserCoordinator: Coordinator {
    var logoutClosure: () -> Void = {}
    init(with authData: UserAuthData, parent: Coordinator) {
        super.init(parent: parent)
    }
}
