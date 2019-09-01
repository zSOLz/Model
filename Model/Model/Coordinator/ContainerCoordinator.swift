//
//  ContainerCoordinator.swift
//  Model
//
//  Created by SOL on 28.04.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

/**
 Custom coordinator represents capabilities of container controller: One active child controller at the moment.
 Use it to implement signle screen with different content screens on it. All transitions can be animated.
 By default this class implements only base container logic. Subclass it to add specipic behavior.
 */
open class ContainerCoordinator: Coordinator {
    /// Strong reference to container controller
    private var innerContainerViewController: ContainerViewController?
    
    /// Initialized container controller's property. In case container controller is not initialized calls *loadContainerViewController()* method (Similar to *loadView()* pattern of UIViewController class).
    open var containerViewController: ContainerViewController {
        get {
            if let controller = innerContainerViewController {
                return controller
            }
            
            loadContainerViewController()
            
            guard let controller = innerContainerViewController else {
                fatalError("Model.ContainerCoordinator.containerViewController\n" +
                    "'containerViewController' variable should be initialized after 'loadContainerViewController' method call.")
            }
            return controller
        }
        set {
            innerContainerViewController = newValue
        }
    }

    /// Child content coordinator.
    /// **Get:** returns first child coordinator added as content.
    /// **Set:** removes current content coordinator, adds new contentCoordinator as child and set its base view controller as content.
    open var contentCoordinator: Coordinator? {
        get {
            return children.first { containerViewController.contentViewController == $0.baseViewController }
        }
        set(newCoordinator) {
            if let coordinator = contentCoordinator {
                coordinator.removeFromParent()
            }
            if let coordinator = newCoordinator {
                add(child: coordinator)
            }
            containerViewController.setContentViewController(newCoordinator?.baseViewController)
        }
    }
    
    /// Creates the conainer view controller that the coordinator manages. You should never call this method directly.
    /// The container coordinator calls method when its container view controller is never beeng initialized.
    /// The default implementation of this method creates object of *ContainerViewController* class and assigns it to *containerViewController* property.
    /// Override this method to assign custom conainer controller.
    open func loadContainerViewController() {
        containerViewController = ContainerViewController()
    }
    
    /// Overrided property of 'Coordinator' class.
    /// Returns the same object as *containerViewController* property.
    override open var baseViewController: UIViewController {
        return containerViewController
    }
    
    /// Overrided property of 'Coordinator' class.
    /// Returns the current active view controller in container view controller
    override open var activeViewController: UIViewController? {
        return containerViewController.contentViewController
    }
}
