//
//  NavigationController.swift
//  Model
//
//  Created by Kirill Budevich on 11/14/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

/**
Internal navigation controller back button deegate.
*/
internal protocol NavigationControllerBackButtonDelegate: class {
    func navigationControllerShouldPopByBackButton(_ navigationController: UINavigationController) -> Bool
}

/**
Internal navigation controller class can helps handle back button touch event.
*/
internal class NavigationController: UINavigationController, UINavigationBarDelegate {
    internal weak var backButtonDelegate: NavigationControllerBackButtonDelegate?

    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        guard topViewController?.navigationItem == item else { return true }
        return backButtonDelegate?.navigationControllerShouldPopByBackButton(self) ?? true
    }
}
