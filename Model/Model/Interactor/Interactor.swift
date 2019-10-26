//
//  Interactor.swift
//  Model
//
//  Created by SOL on 28.04.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

/**
 The base class for the business logic. Split the application business logic to separate
 **use cases** and put each use case to a single interactor. Follow the *'Single Responsibility'* design principle
 during the development of the business logic (interactors) layer.
 Custom interactors may contain strong references to:
 - Data managers (or other instances) that can load and store business models
 - Data sessions - objects that hold mutable application state
 - Other interactors (if it is really nesessary)
 */
open class Interactor {
    public init() {
        // Do nothing. Empty constructor required
    }
}
