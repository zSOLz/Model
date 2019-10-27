//
//  UIImageView.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/27/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL?) {
        guard let url = url else {
            self.image = nil
            return
        }
        DispatchQueue.global().async { [weak self] in
            let image = UIImage(contentsOfFile: url.path)
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
    }
}
