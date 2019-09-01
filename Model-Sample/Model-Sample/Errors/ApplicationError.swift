//
//  ApplicationError.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

class ApplicationError: Error {
    let message: String
    
    init(message: String) {
        self.message = message
    }
}
