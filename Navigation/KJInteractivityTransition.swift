//
//  InteractivityTransition.swift
//  transitionAnimation
//
//  Created by hjk on 2017/8/18.
//  Copyright © 2017年 kobehjk. All rights reserved.
//

import UIKit

enum GestureType {
    case pan
    case screenEdge
}

enum ViewControllerAnimationType {
    case Slider
    case Scale
}

enum PanStateDirectionType{
    case none
    case left
    case right
}



class KJInteractivityTransition: NSObject,UINavigationControllerDelegate {

    var pushViewController :UIViewController?
    var gestureType :GestureType
    var controllerAnimationType :ViewControllerAnimationType
    
    let pushSliderAnimation = KJPushSliderAnimation()
    let popSliderAnimation = KJPopSliderAnimation()
    let pushScaleAnimation = KJPushScaleAnimation()
    let popScaleAnimation = KJPopScaleAnimation()
    
    var interactiveTransition :UIPercentDrivenInteractiveTransition? = UIPercentDrivenInteractiveTransition()
    var viewController : UIViewController
    var panGestureRecognizer :UIPanGestureRecognizer?
    var panStateDirectionType :PanStateDirectionType
    
    
    
    init(gestureType :GestureType, controlAnimationType :ViewControllerAnimationType, viewController:UIViewController) {
        self.gestureType = gestureType
        self.controllerAnimationType = controlAnimationType
        self.panStateDirectionType = .none
        self.viewController = viewController
        self.viewController.setKj_LeftGesture(kj_leftGesture: false)
        self.viewController.setKj_RightGesture(kj_rightGesture: true)
        
        super.init()
        
        addPanGestureRecognizer()
        
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactiveTransition
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            
            guard self.viewController.kj_PushAnimation() == false else {
                return nil
            }
            if self.controllerAnimationType == .Slider {
                return self.pushSliderAnimation
            }else{
                return self.pushScaleAnimation
            }
            
        } else if operation == .pop {
            
            guard self.viewController.kj_PopAnimation() == false else {
                return nil
            }
            if self.controllerAnimationType == .Slider {
                return self.popSliderAnimation
            }else{
                return self.popScaleAnimation
            }
            
        }
        
        return nil
    }
    
}

extension KJInteractivityTransition:UIGestureRecognizerDelegate{
    func addPanGestureRecognizer(){
        
        if panGestureRecognizer != nil{
            self.viewController.view.removeGestureRecognizer(panGestureRecognizer!)
        }
        
        if self.gestureType == .screenEdge {
            
            let gesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(gestureAction(gesture:)))
            gesture.delegate = self
            gesture.edges = .left
            gesture.edges = .right
            self.viewController.view.addGestureRecognizer(gesture)
            self.panGestureRecognizer = gesture
        
        } else {
            
            let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(gestureAction(gesture:)))
            gesture.delegate = self
            self.viewController.view.addGestureRecognizer(gesture)
            self.panGestureRecognizer = gesture
            
        }
        
    }
    
    func gestureAction(gesture:UIPanGestureRecognizer) {
        
        var tranX :CGFloat = 0
        var per :Double = 0.0
        
        if gesture.translation(in: self.viewController.view).x >= 0 && self.panStateDirectionType != .right {
            tranX = gesture.translation(in: self.viewController.view).x
            per = min(1, max(Double(0), Double(tranX/self.viewController.view.bounds.width)))
            
            if gesture.state == .began {
                
                self.panStateDirectionType = .left
                self.interactiveTransition = UIPercentDrivenInteractiveTransition()
                self.viewController.navigationController?.popViewController(animated: true)
            
            } else if (gesture.state == .changed){
                
                interactiveTransition?.update(CGFloat(per))
                
            } else if (gesture.state == .ended || gesture.state == .cancelled || gesture.state == .failed){
                
                if per > 0.5 {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.interactiveTransition?.finish()
                    })
                } else {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.interactiveTransition?.cancel()
                    })
                }
                self.interactiveTransition = nil
                self.panStateDirectionType = .none
                
            }
            
        }
        
        else if gesture.translation(in: self.viewController.view).x <= 0 && self.panStateDirectionType != .left && self.viewController.kj_RightGesture() != true {
            
            tranX = fabs(gesture.translation(in: self.viewController.view).x)
            per = min(1, max(Double(0), Double(tranX/self.viewController.view.bounds.width)))
            
            if gesture.state == .began {
                
                self.panStateDirectionType = .right
                self.interactiveTransition = UIPercentDrivenInteractiveTransition()
                self.viewController.navigationController?.pushViewController(self.pushViewController!, animated: true)
                
            } else if (gesture.state == .changed){
                
                interactiveTransition?.update(CGFloat(per))
                
            } else if (gesture.state == .ended || gesture.state == .cancelled || gesture.state == .failed){
                
                if per > 0.5 {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.interactiveTransition?.finish()
                    })
                    
                } else {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.interactiveTransition?.cancel()
                    })
                    
                }
                self.interactiveTransition = nil
                self.panStateDirectionType = .none
                
            }
            
        }
        
        else if gesture.state == .ended || gesture.state == .cancelled || gesture.state == .failed {
            UIView.animate(withDuration: 0.5, animations: {
                self.interactiveTransition?.cancel()
            })
            self.interactiveTransition = nil
            self.panStateDirectionType = .none
        }
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !self.viewController.kj_LeftGesture()
    }
    
}

extension UIViewController{
    
    func kj_LeftGesture() -> Bool {
        return (objc_getAssociatedObject(self, "kj_LeftGesture") != nil)
    }
    
    func setKj_LeftGesture(kj_leftGesture:Bool) {
        objc_setAssociatedObject(self, "kj_LeftGesture", kj_leftGesture, .OBJC_ASSOCIATION_ASSIGN)
    }
    
    func kj_RightGesture() -> Bool {
        return (objc_getAssociatedObject(self, "kj_RightGesture") != nil)
    }
    
    func setKj_RightGesture(kj_rightGesture:Bool) {
        objc_setAssociatedObject(self, "kj_RightGesture", kj_rightGesture, .OBJC_ASSOCIATION_ASSIGN)
    }
    
    func kj_PopAnimation() -> Bool {
        return (objc_getAssociatedObject(self, "kj_PopAnimation") != nil)
    }
    
    func setKj_PopAnimation(kj_pop:Bool) {
        objc_setAssociatedObject(self, "kj_PopAnimation", kj_pop, .OBJC_ASSOCIATION_ASSIGN)
    }
    
    func kj_PushAnimation() -> Bool {
        return (objc_getAssociatedObject(self, "kj_PushAnimation") != nil)
    }
    
    func setKj_PushAnimation(kj_push:Bool) {
        objc_setAssociatedObject(self, "kj_PushAnimation", kj_push, .OBJC_ASSOCIATION_ASSIGN)
    }
    
}






