//
//  UIView+Spring.swift

//
//  Created by sondang on 8/13/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

typealias animateCompleteBlock = (Bool) -> Void

class SSMove {
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    init() {}
    
    convenience init(x: CGFloat, y: CGFloat) {
        self.init()
        
        self.x = x
        self.y = y
    }
}

class SSScale {
    
    var x: CGFloat = 1
    var y: CGFloat = 1
    
    init() {}
    
    convenience init(x: CGFloat, y: CGFloat) {
        self.init()
        
        self.x = x
        self.y = y
    }
}

class SSAnimation {
    
    var duration: TimeInterval = 0.5
    var delay: TimeInterval = 0
    var damping: CGFloat = 0.8
    var initialSpringVelocity: CGFloat = 1
    var animateFrom = true
    var options: UIViewAnimationOptions = [.curveEaseInOut]
    var show = true
    var viewOpacity: CGFloat = 1
    var scale: SSScale?
    var move: SSMove?
    
    static var animatedDefault = SSAnimation()
    
    init() {}
    
    convenience init(
        _ view: UIView?,
        duration: TimeInterval = 0.5,
        delay: TimeInterval = 0,
        damping: CGFloat = 0.8,
        initialSpringVelocity: CGFloat = 1,
        scale: SSScale? = nil,
        move: SSMove? = nil) {
        self.init()
        
        self.duration = duration
        self.delay = delay
        self.damping = damping
        self.initialSpringVelocity = initialSpringVelocity
        
        if let _view = view {
            viewOpacity = _view.alpha
        }
        
        self.scale = scale
        self.move = move
    }
    
}

extension UIView {
    
    func moveBottom(moveIn: Bool = true, _ complete: animateCompleteBlock? = nil) {
        move(moveIn: moveIn, x: 0, y: 160, complete)
    }
    
    func moveIn(right: Bool = true, _ complete: animateCompleteBlock? = nil) {
        var from: CGFloat = -300
        if right {
            from = -from
        }
        
        move(moveIn: true, x: from, y: 0, complete)
    }
    
    func moveOut(right: Bool = true, _ complete: animateCompleteBlock? = nil) {
        var from: CGFloat = -300
        if right {
            from = -from
        }
        
        move(moveIn: false, x: from, y: 0, complete)
    }
    
    private func move(moveIn: Bool, x: CGFloat, y: CGFloat, _ complete: animateCompleteBlock? = nil) {
        let move: SSMove = SSMove(x: x, y: y)
        let animated = SSAnimation.init(self, duration: 0.5, damping: 0.8, initialSpringVelocity: 1, move: move)
        animated.show = moveIn
        animate(animated, animateBlock: nil, complete)
    }
    
    // MARK: - show hide functions
    func show(_ complete: animateCompleteBlock? = nil) {
        show(true, complete)
    }
    
    func hide(_ complete: animateCompleteBlock? = nil) {
        show(false, complete)
    }
    
    private func show(_ shouldShow: Bool, _ complete: animateCompleteBlock? = nil) {
        let animated = SSAnimation.init(self, duration: 0.35, damping: 0.8, initialSpringVelocity: 1)
        animated.show = shouldShow
        animate(animated, animateBlock: nil, complete)
    }
    
    // MARK: - pop functions
    func popOut(_ complete: animateCompleteBlock? = nil) {
        pop(false, complete)
    }
    
    func popIn(_ complete: animateCompleteBlock? = nil) {
        pop(true, complete)
    }
    
    private func pop(_ sIn: Bool, _ complete: animateCompleteBlock? = nil) {
        let scale = SSScale(x: 1.3, y: 1.3)
        let animated = SSAnimation.init(self, duration: 0.35, damping: 0.8, initialSpringVelocity: 1, scale: scale)
        animated.show = sIn
        animate(animated, animateBlock: nil, complete)
    }
    
    // MARK: - Core animation
    private func animate(_ animate: SSAnimation = SSAnimation.animatedDefault, animateBlock: (() -> Void)? = nil, _ complete: animateCompleteBlock? = nil) {
        let duration = animate.duration
        let delay = animate.delay
        let damping = animate.damping
        let velocity = animate.initialSpringVelocity
        let options = animate.options
        
        if animate.show {
            alpha = 0.0
            
            if let _scale = animate.scale {
                transform = CGAffineTransform(scaleX: _scale.x, y: _scale.y)
            }
            
            if let _move  = animate.move {
                transform = CGAffineTransform(translationX: _move.x, y: _move.y)
            }
        }
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            if animate.show {
                // reset transform
                strongSelf.transform = CGAffineTransform.identity
                strongSelf.alpha = animate.viewOpacity
                strongSelf.isHidden = false
            }
            else {
                strongSelf.alpha = 0
                if let scale = animate.scale {
                    strongSelf.transform = CGAffineTransform(scaleX: scale.x, y: scale.y)
                }
                
                if let _move  = animate.move {
                    strongSelf.transform = CGAffineTransform(translationX: _move.x, y: _move.y)
                }
            }
            
        }) { (finished) in
            if complete != nil {
                complete!(finished)
            }
        }
    }
    
}

/*
 
 base on https://github.com/matthewcheok/Fluent
 Thank to matthewcheok
 
 */

public class Fluent {
    public typealias AnimationBlock = () -> Void
    
    fileprivate var animations: [AnimationBlock] = []
    private let duration: TimeInterval
    private let velocity: CGFloat
    private let damping: CGFloat
    private let options: UIViewAnimationOptions
    fileprivate var next: Fluent?
    
    init(duration: TimeInterval, velocity: CGFloat, damping: CGFloat, options: UIViewAnimationOptions) {
        self.duration = duration
        self.velocity = velocity
        self.damping = damping
        self.options = options
    }
    
    func performAdditionalAnimations() {
    }
    
    deinit {
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: options, animations: {
            [animations, performAdditionalAnimations] in
            for animation in animations {
                animation()
            }
            performAdditionalAnimations()
            }, completion: {
                [next] (finished) in
                next
        })
    }
}

public class ViewFluent: Fluent {
    private let view: UIView
    
    enum AffineTransformType {
        case None
        case Absolute
        case Relative
    }
    
    private var transformType: AffineTransformType = .None
    private var transformMatrix = CGAffineTransform.identity
    private let transformError = "You cannot mix absolute and relative transforms"
    
    init(view: UIView, duration: TimeInterval, velocity: CGFloat, damping: CGFloat, options: UIViewAnimationOptions) {
        self.view = view
        super.init(duration: duration, velocity: velocity, damping: damping, options: options)
    }
    
    public func scale(factor: CGFloat) -> Self {
        precondition(transformType != .Relative, transformError)
        transformType = .Absolute
        transformMatrix = transformMatrix.scaledBy(x: factor, y: factor)
        
        return self
    }
    
    public func translate(x: CGFloat, _ y: CGFloat) -> Self {
        precondition(transformType != .Relative, transformError)
        transformType = .Absolute
        transformMatrix = transformMatrix.translatedBy(x: x, y: y)
        
        return self
    }
    
    public func rotate(cycles: CGFloat) -> Self {
        precondition(transformType != .Relative, transformError)
        transformType = .Absolute
        transformMatrix = transformMatrix.rotated(by: cycles * 2 * CGFloat(Double.pi/2))
        
        return self
    }
    
    public func scaleBy(factor: CGFloat) -> Self {
        precondition(transformType != .Absolute, transformError)
        transformType = .Relative
        transformMatrix = transformMatrix.scaledBy(x: factor, y: factor)
        
        return self
    }
    
    public func translateBy(x: CGFloat, _ y: CGFloat) -> Self {
        precondition(transformType != .Absolute, transformError)
        transformType = .Relative
        transformMatrix = transformMatrix.translatedBy(x: x, y: y)
        
        return self
    }
    
    public func rotateBy(cycles: CGFloat) -> Self {
        precondition(transformType != .Absolute, transformError)
        transformType = .Relative
        transformMatrix = transformMatrix.rotated(by: cycles * 2 * CGFloat(Double.pi/2))
        
        return self
    }
    
    override func performAdditionalAnimations() {
        if transformType == .Absolute {
            view.transform = transformMatrix
        }
        else if transformType == .Relative {
            view.transform = view.transform.concatenating(transformMatrix)
        }
    }
    
    public func backgroundColor(color: UIColor) -> Self {
        animations.append({
            [view] in
            view.backgroundColor = color
        })
        
        return self
    }
    
    public func alpha(alpha: CGFloat) -> Self {
        animations.append({
            [view] in
            view.alpha = alpha
        })
        
        return self
    }
    
    public func frame(frame: CGRect) -> Self {
        animations.append({
            [view] in
            view.frame = frame
        })
        
        return self
    }
    
    public func bounds(bounds: CGRect) -> Self {
        animations.append({
            [view] in
            view.bounds = bounds
        })
        
        return self
    }
    
    public func center(center: CGPoint) -> Self {
        animations.append({
            [view] in
            view.center = center
        })
        
        return self
    }
    
    public func custom(animation: @escaping AnimationBlock) -> Self {
        animations.append(animation)
        
        return self
    }
    
    public func waitThenAnimate(duration: TimeInterval, velocity: CGFloat = 0, damping: CGFloat = 1, options: UIViewAnimationOptions = [.allowUserInteraction, .beginFromCurrentState]) -> ViewFluent {
        precondition(next == nil, "You have already specified a completion handler")
        let after = ViewFluent(view: view, duration: duration, velocity: velocity, damping: damping, options: options)
        next = after
        
        return after
    }
}

public extension UIView {
    public func animate(duration: TimeInterval, velocity: CGFloat = 0, damping: CGFloat = 1, options: UIViewAnimationOptions = [.allowUserInteraction, .beginFromCurrentState]) -> ViewFluent {
        return ViewFluent(view: self, duration: duration, velocity: velocity, damping: damping, options: options)
    }
}
