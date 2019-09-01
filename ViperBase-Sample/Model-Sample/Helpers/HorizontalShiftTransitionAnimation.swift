//
//  HorizontalShiftTransitionAnimation.swift
//  Model-Sample
//
//  Created by SOL on 20.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model
import UIKit

class HorizontalShiftTransitionAnimation: NSObject {
    enum Direction {
        case left
        case right
    }
    
    let direciton: Direction
    let duration: TimeInterval
    
    init(direciton: Direction = .left, duration: TimeInterval = 0.3) {
        self.direciton = direciton
        self.duration = duration
    }
}

extension HorizontalShiftTransitionAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            assertionFailure("toViewController not found")
            return
        }
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        let containerView = transitionContext.containerView
        
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewController)
        var toViewStartFrame = toViewFinalFrame
        var fromViewFinalFrame = toViewFinalFrame

        switch direciton {
        case .left:
            fromViewFinalFrame.origin.x = -fromViewFinalFrame.width
            toViewStartFrame.origin.x = toViewStartFrame.width
        
        case .right:
            fromViewFinalFrame.origin.x = fromViewFinalFrame.width
            toViewStartFrame.origin.x = -toViewStartFrame.width
        }
        
        toView?.frame = toViewStartFrame
        containerView.layoutIfNeeded()
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView?.frame = fromViewFinalFrame
            toView?.frame = toViewFinalFrame
            containerView.layoutIfNeeded()
        }, completion: { completed in
            transitionContext.completeTransition(completed)
        })
    }
}
