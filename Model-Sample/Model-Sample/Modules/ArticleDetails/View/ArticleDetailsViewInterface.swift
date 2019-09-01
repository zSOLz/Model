//
//  ArticleDetailsViewInterface.swift
//  Model-Sample
//
//  Created by SOL on 03.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

struct ArticleDetailsViewModel {
    let title: String
    let image: UIImage?
    let author: String
    let text: String
}

protocol ArticleDetailsViewInterface: ViewInterface {
    func setup(viewModel: ArticleDetailsViewModel)
}
