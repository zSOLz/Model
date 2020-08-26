//
//  NavigationCoordinator.swift
//  Model
//
//  Created by SOL on 28.04.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

/**
 Custom coordinator represents capabilities of navigation controller: This is base class to use navigation controller's push/pop logic.
 Use it to implement navigation based routing logic.
 By default this class implements only base navigation controller logic. Subclass it to add specipic behavior.
 */
open class NavigationCoordinator: Coordinator, UINavigationControllerDelegate {
    /// Strong reference to navigation controller
    private var innerNavigationController: UINavigationController?
    
    /// Initialized navigation controller's property. In case navigation controller is not initialized calls *loadNavigationController()* method (Similar to *loadView()* pattern of UIViewController class).
    open var navigationController: UINavigationController {
        get {
            if let controller = innerNavigationController {
                return controller
            }

            loadNavigationController()
            guard let controller = innerNavigationController else {
                fatalError("Model.NavigationCoordinator.navigationController\n" +
                    "'navigationController' variable should be initialized after 'loadNavigationController' method call.")
            }
            navigationControllerDidLoad()
            return controller
        }
        set {
            innerNavigationController = newValue
            innerNavigationController?.delegate = self
        }
    }
    
    /// Overrided property of 'Coordinator' class.
    /// Returns the same object as *navigationController* property.
    override open var baseViewController: UIViewController {
        return navigationController
    }
    
    /// Overrided property of 'Coordinator' class.
    /// Returns the top view controller of navigation controller
    override open var activeViewController: UIViewController? {
        return navigationController.topViewController
    }

    /// Return the value that indicates the possibility to edges swipe back
    open var isSwipeBackEnabled: Bool {
        return navigationController.viewControllers.count > 1
    }
    
    /// Creates the navigation controller that the stack coordinator manages. You should never call this method directly.
    /// The stack coordinator calls method when its navigation controller is never beeng initialized.
    /// The default implementation of this method creates object of *PresentableNavigationController* class and assigns it to *navigationController* property.
    /// Override this method to assign custom navigation controller.
    open func loadNavigationController() {
        navigationController = NavigationController()
    }
    
    /// Calls after navigation controller was loaded
    open func navigationControllerDidLoad() {
        navigationController.delegate = self
        navigationController.interactivePopGestureRecognizer?.delegate = self
        (navigationController as? NavigationController)?.backButtonDelegate = self
    }
    
    /// Returns last popped view controller with given type if exists. Otherwise returns nil.
    /// - parameter type: view controller's type to find
    open func lastViewController<ControllerType: UIViewController>(withType type: ControllerType.Type) -> UIViewController? {
        return navigationController.viewControllers.reversed().first { $0 is ControllerType }
    }

    /// Returns **true** if view controller with given type is found in navigation controller's stack. Otherwise returns **false**.
    /// - parameter type: view controller type to find
    open func containsViewController<ControllerType: UIViewController>(withType type: ControllerType.Type) -> Bool {
        return (lastViewController(withType: ControllerType.self) != nil)
    }
    
    /// Pops all view controllers till controller with given type. View controller with given type will be at the top of navigation stack.
    /// If navigation controller does not contain view controller with given type the method does nothing.
    /// - parameter type: view controller's type to  find
    /// - parameter animated: should pop animation be animated or not
    /// - returns: array of popped view controller. If navigation controller does not contain view controller with given type returns empty array.
    @discardableResult open func popToFirstViewController<ControllerType: UIViewController>(withType type: ControllerType.Type, animated: Bool) -> [UIViewController] {
        guard let lastViewController = lastViewController(withType: ControllerType.self) else {
            return []
        }
        return navigationController.popToViewController(lastViewController, animated: animated) ?? []
    }
    
    /// Pops top view controller
    /// - parameter animated: should pop animation be animated or not
    @discardableResult open func popViewController(animated: Bool) -> UIViewController? {
        return navigationController.popViewController(animated: animated)
    }

    /// Push view controller
    /// - parameter viewController: controller to push
    /// - parameter animated: should pop animation be animated or not
    open func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    /// Clear stack and push view controller
    /// - parameter viewController: controller to push
    /// - parameter animated: should pop animation be animated or noz
    open func pushFirstViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.setViewControllers([viewController], animated: animated)
    }

    /// Push coordinator
    /// - parameter coordinator: coordinator to push
    /// - parameter animated: should pop animation be animated or not
    open func pushCoordinator(_ coordinator: Coordinator, animated: Bool = true) {
        add(child: coordinator)
        pushViewController(coordinator.baseViewController, animated: animated)
    }

    /// Is first coordinator at stack
    /// - parameter coordinator: coordinator to get is first
    /// - returns: Bool if coordinator is first at navigation stack.
    open func isFirstCoordinatorAtStack(_ coordinator: Coordinator) -> Bool {
        guard let index = coordinatorIndexAtStack(coordinator) else { return false }
        return index == 0
    }

    /// Get coordinator index from stack
    /// - parameter coordinator: coordinator to get index
    /// - returns: Index of coordinator at navigation stack, if exist.
    open func coordinatorIndexAtStack(_ coordinator: Coordinator) -> Int? {
        return navigationController.viewControllers.firstIndex(of: coordinator.baseViewController)
    }
}

// MARK: - UINavigationControllerDelegate
extension NavigationCoordinator {
    open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        clearUnusedChildCoordinators()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension NavigationCoordinator: UIGestureRecognizerDelegate {
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard isSwipeBackEnabled else { return false }
        return handleIntercativeDismissal(.navigationSwipeBack)
    }
}

// MARK: - NavigationControllerBackButtonDelegate
extension NavigationCoordinator: NavigationControllerBackButtonDelegate {
    func navigationControllerShouldPopByBackButton(_ navigationController: UINavigationController) -> Bool {
        return handleIntercativeDismissal(.navigationBackButton)
    }
}

// MARK: - Private
private extension NavigationCoordinator {
    func handleIntercativeDismissal(_ interactiveDismissal: InteractiveDismissal) -> Bool {
        guard let interactiveDismissalHandler = navigationController.topViewController as? InteractiveDismissalHandler else {
            return true
        }

        var isInteractiveDissmissalAllowed = false
        var isPopUncompleted = false
        interactiveDismissalHandler.handleInteractiveDismissal(interactiveDismissal, allow: { [weak self] in
            if isPopUncompleted {
                self?.popViewController(animated: true)
            }
            isInteractiveDissmissalAllowed = true
        }, deny: {})
        isPopUncompleted = true
        return isInteractiveDissmissalAllowed
    }
}
