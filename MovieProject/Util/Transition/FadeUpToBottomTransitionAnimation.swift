//
//  FadeUpToBottomTransitionAnimation.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/24/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation
import UIKit

final class FadeUpToBottomTransitionAnimation: NSObject {
    
    var isPresenting: Bool
    
    struct Constants {
        struct Animation {
            static let duration: TimeInterval = 0.8
            static let presentingYPositionFactor: CGFloat = 1
        }
    }
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
}

extension FadeUpToBottomTransitionAnimation: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.Animation.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if self.isPresenting {
            presenting(transitionContext: transitionContext)
        } else {
            dismissing(transitionContext: transitionContext)
        }
    }
    
    func presenting(transitionContext: UIViewControllerContextTransitioning)
    {
        guard let toView = transitionContext.viewController(forKey: .to)?.view else {
                return
        }
        
        let containerView = transitionContext.containerView
        let toViewFrame = toView.frame
        containerView.addSubview(toView)
        
        toView.alpha = 0.0
        toView.frame = CGRect(x: 0, y: -(containerView.frame.height * Constants.Animation.presentingYPositionFactor), width: toViewFrame.width, height: toViewFrame.height)
        
        UIView.animate(withDuration: Constants.Animation.duration, animations: {
            toView.alpha = 1
            toView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: toViewFrame.width, height: toViewFrame.height)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func dismissing(transitionContext: UIViewControllerContextTransitioning){
    
        guard let fromView = transitionContext.viewController(forKey: .from)?.view,
            let toView = transitionContext.viewController(forKey: .to)?.view else {
                return
        }
        
        let containerView = transitionContext.containerView
        fromView.endEditing(true)
        
        containerView.insertSubview(toView, at: 0)
        
        fromView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: fromView.frame.width, height: fromView.frame.height)
        fromView.alpha = 1.0
        UIView.animate(withDuration: Constants.Animation.duration, animations: {
            fromView.alpha = 0.0
            fromView.frame = CGRect(x: 0, y: -(containerView.frame.height * Constants.Animation.presentingYPositionFactor), width: fromView.frame.width, height: fromView.frame.height)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}
