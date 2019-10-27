//
//  DateFormatter.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/27/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var common: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
}
