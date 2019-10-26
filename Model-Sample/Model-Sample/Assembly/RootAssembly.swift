//
//  RootAssembly.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Model

class RootAssembly: Assembly {
    static func makeRootCoordinator() -> RootCoordinator {
        return RootCoordinator()
    }
}
