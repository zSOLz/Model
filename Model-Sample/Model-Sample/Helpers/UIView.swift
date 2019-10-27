//
//  UIView.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/20/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

extension UIView {
    func roundCornersWithMaximumRadius() {
        layer.cornerRadius = min(frame.width, frame.height) / 2
        layer.masksToBounds = true
    }
}
