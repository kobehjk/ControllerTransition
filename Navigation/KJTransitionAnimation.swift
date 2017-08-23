//
//  TransitionAnimation.swift
//  transitionAnimation
//
//  Created by hjk on 2017/8/18.
//  Copyright © 2017年 kobehjk. All rights reserved.
//

import UIKit

let duration = 0.5
let coverAlpha :CGFloat = 0.2

class KJPushSliderAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        let containView = transitionContext.containerView
        
        let finalFrame = transitionContext.finalFrame(for: toVC!)
        fromVC?.view.frame = finalFrame
        
        toVC?.view.layer.shadowPath = UIBezierPath.init(rect: CGRect.init(x: (toVC?.view.bounds.origin.x)!-5, y: (toVC?.view.bounds.origin.y)!, width: (toVC?.view.bounds.size.width)!, height: (fromVC?.view.bounds.height)!)).cgPath
        toVC?.view.layer.shadowOpacity = 0.2
        toVC?.view.layer.shadowColor = UIColor.black.cgColor
        
        let alphaCoverView = UIView.init(frame: finalFrame)
        alphaCoverView.backgroundColor = UIColor.black
        alphaCoverView.alpha = 0.0
        
        toVC?.view.frame = finalFrame.offsetBy(dx: finalFrame.size.width, dy: 0)
        
        containView.addSubview((fromVC?.view)!)
        containView.addSubview(alphaCoverView)
        containView.addSubview((toVC?.view)!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            toVC?.view.frame = finalFrame
            alphaCoverView.alpha = coverAlpha
            fromVC?.view.frame = finalFrame.offsetBy(dx: -finalFrame.size.width, dy: 0)
        }) { (finish) in
            alphaCoverView.removeFromSuperview()
            fromVC?.view.layer.shadowColor = UIColor.clear.cgColor
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}

class KJPopSliderAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        let containView = transitionContext.containerView
        
        let finalFrame = transitionContext.finalFrame(for: toVC!)
        fromVC?.view.frame = finalFrame
        
        fromVC?.view.layer.shadowPath = UIBezierPath.init(rect: CGRect.init(x: (toVC?.view.bounds.origin.x)!-5, y: (toVC?.view.bounds.origin.y)!, width: (toVC?.view.bounds.size.width)!, height: (fromVC?.view.bounds.height)!)).cgPath
        fromVC?.view.layer.shadowOpacity = 0.2
        fromVC?.view.layer.shadowColor = UIColor.black.cgColor
        
        let alphaCoverView = UIView.init(frame: finalFrame)
        alphaCoverView.backgroundColor = UIColor.black
        alphaCoverView.alpha = coverAlpha
        
        toVC?.view.frame = finalFrame.offsetBy(dx: -finalFrame.size.width+UIScreen.main.bounds.width*0.6, dy: 0)
        
        containView.addSubview((toVC?.view)!)
        containView.addSubview(alphaCoverView)
        containView.addSubview((fromVC?.view)!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toVC?.view.frame = finalFrame
            alphaCoverView.alpha = 0
            fromVC?.view.frame = finalFrame.offsetBy(dx: finalFrame.size.width, dy: 0)
        }) { (finish) in
            alphaCoverView.removeFromSuperview()
            fromVC?.view.layer.shadowColor = UIColor.clear.cgColor
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }
}

class KJPushScaleAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        let containView = transitionContext.containerView
        
        let finalFrame = transitionContext.finalFrame(for: toVC!)
        fromVC?.view.frame = finalFrame
        
        toVC?.view.layer.shadowPath = UIBezierPath.init(rect: CGRect.init(x: (toVC?.view.bounds.origin.x)!-5, y: (toVC?.view.bounds.origin.y)!, width: (toVC?.view.bounds.size.width)!, height: (fromVC?.view.bounds.height)!)).cgPath
        toVC?.view.layer.shadowOpacity = 0.2
        toVC?.view.layer.shadowColor = UIColor.black.cgColor
        
        let alphaCoverView = UIView.init(frame: finalFrame)
        alphaCoverView.backgroundColor = UIColor.black
        alphaCoverView.alpha = 0
        
        toVC?.view.frame = finalFrame.offsetBy(dx: finalFrame.size.width, dy: 0)
        
        containView.addSubview((fromVC?.view)!)
        containView.addSubview(alphaCoverView)
        containView.addSubview((toVC?.view)!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toVC?.view.frame = finalFrame
            alphaCoverView.alpha = 0.0
            fromVC?.view.frame = CGRect.init(x: 10, y: 15, width: finalFrame.size.width - 20, height: finalFrame.size.height - 30);
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            alphaCoverView.removeFromSuperview()
            fromVC?.view.layer.shadowColor = UIColor.clear.cgColor
        }
        
    }
}

class KJPopScaleAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        let containView = transitionContext.containerView
        
        let finalFrame = transitionContext.finalFrame(for: toVC!)
        fromVC?.view.frame = finalFrame
        
        fromVC?.view.layer.shadowPath = UIBezierPath.init(rect: CGRect.init(x: (fromVC?.view.bounds.origin.x)!-5, y: (fromVC?.view.bounds.origin.y)!, width: (fromVC?.view.bounds.size.width)!, height: (toVC?.view.bounds.height)!)).cgPath
        fromVC?.view.layer.shadowOpacity = 0.2
        fromVC?.view.layer.shadowColor = UIColor.black.cgColor
        
        let alphaCoverView = UIView.init(frame: finalFrame)
        alphaCoverView.backgroundColor = UIColor.black
        alphaCoverView.alpha = coverAlpha
        
        toVC?.view.frame = CGRect.init(x: 10, y: 15, width: finalFrame.size.width - 20, height: finalFrame.size.height - 30)
        
        containView.addSubview((toVC?.view)!)
        containView.addSubview(alphaCoverView)
        containView.addSubview((fromVC?.view)!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            toVC?.view.frame = finalFrame
            alphaCoverView.alpha = 0.0
            fromVC?.view.frame = finalFrame.offsetBy(dx: finalFrame.size.width, dy: 0)
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            alphaCoverView.removeFromSuperview()
            fromVC?.view.layer.shadowColor = UIColor.clear.cgColor
        }
    }
}
