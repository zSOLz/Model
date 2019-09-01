//
//  ContainerViewControllerTransitionContext.swift
//  Model
//
//  Created by SOL on 14.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

/**
 Transition context that represents basic non-interactive logic
 */
open class ContainerViewControllerTransitionContext: NSObject, UIViewControllerContextTransitioning {
    open var fromViewController: UIViewController?
    open var toViewController: UIViewController?
    open var containerView: UIView
    
    public init(containerView: UIView, from: UIViewController? = nil, to: UIViewController? = nil) {
        self.containerView = containerView
        self.fromViewController = from
        self.toViewController = to
    }
    
    open var isAnimated: Bool {
        return true
    }
    
    open var isInteractive: Bool {
        return false
    }
    
    open var transitionWasCancelled: Bool {
        return false
    }
    
    open var presentationStyle: UIModalPresentationStyle {
        return .custom
    }
    
    open func updateInteractiveTransition(_ percentComplete: CGFloat) {
        // Does nothing. Interactive transition does not support in this version.
    }
    
    open func finishInteractiveTransition() {
        // Does nothing. Interactive transition does not support in this version.
    }
    
    open func cancelInteractiveTransition() {
        // Does nothing. Interactive transition does not support in this version.
    }
    
    @available(iOS 10.0, *)
    open func pauseInteractiveTransition() {
        // Does nothing. Interactive transition does not support in this version.
    }
    
    open func completeTransition(_ didComplete: Bool) {
        // Does nothing.
    }
    
    public func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        switch key {
        case UITransitionContextViewControllerKey.from:
            return fromViewController
            
        case UITransitionContextViewControllerKey.to:
            return toViewController
            
        default:
            return nil
        }
    }
    
    @available(iOS 8.0, *)
    public func view(forKey key: UITransitionContextViewKey) -> UIView? {
        switch key {
        case UITransitionContextViewKey.from:
            return fromViewController?.view
            
        case UITransitionContextViewKey.to:
            return toViewController?.view
            
        default:
            return nil
        }
    }
    
    @available(iOS 8.0, *)
    public var targetTransform: CGAffineTransform {
        return .identity
    }
    
    public func initialFrame(for vc: UIViewController) -> CGRect {
        return containerView.bounds
    }
    
    public func finalFrame(for vc: UIViewController) -> CGRect {
        return containerView.bounds
    }
}
