//
//  UIview.swift
//  FinstroPay
//
//  Created by sondang on 6/28/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension UIView {
    
    static func effectView(frame: CGRect, effect: UIVisualEffect) ->  UIView{
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = frame
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return effectView
    }
    
    static func blurEffectView(frame: CGRect, style: UIBlurEffectStyle) -> UIView {
        let blurEffect = UIBlurEffect(style: style)
        return UIView.effectView(frame: frame, effect: blurEffect)
    }
    
    func gradient(colors: [CGColor], start: CGPoint = CGPoint(x: 0, y: 0), end: CGPoint = CGPoint(x: 1, y: 0), locations: [NSNumber] = [0, 1]) {
        //layoutIfNeeded()
        let layer = UIView(frame: bounds)
        layer.layer.cornerRadius = 5
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = start
        gradient.endPoint = end
        gradient.cornerRadius = 5
        layer.layer.addSublayer(gradient)
        
        addSubview(layer)
    }
    
}
