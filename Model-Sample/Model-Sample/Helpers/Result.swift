//
//  Result.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/19/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Foundation

extension Result {
    func on(success: ((Success) -> Void)?, failure: ((Failure) -> Void)?) {
        if case let .success(value) = self {
            success?(value)
        }
        if case let .failure(value) = self {
            failure?(value)
        }
    }

    func onSuccess(_ action: ((Success) -> Void)?) {
        if case let .success(value) = self {
            action?(value)
        }
    }
    
    func onFailure(_ action: ((Failure) -> Void)?) {
        if case let .failure(value) = self {
            action?(value)
        }
    }
}
