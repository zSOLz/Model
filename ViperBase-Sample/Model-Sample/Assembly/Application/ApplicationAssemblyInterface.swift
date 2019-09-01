//
//  ApplicationAssemblyInterface.swift
//  Model-Sample
//
//  Created by SOL on 04.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

protocol ApplicationAssemblyInterface: AssemblyInterface {
    func newsFeedRouter() -> NewsFeedRouter
    func profileRouter() -> ProfileRouter
}
