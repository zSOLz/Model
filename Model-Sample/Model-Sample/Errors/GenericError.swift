//
//  ApplicationError.swift
//  Model-Sample
//
//  Created by SOL on 08.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

/// Default error. Covers all error cases in this code sample. Do not use the same approach in production.
enum GenericError: Error {
    case noResultForParameter
    case invalidUserRegistrationCredentials
    case invalidParameters
    case accountDuplication
    case userNotFound
    case notAuthorized
}
