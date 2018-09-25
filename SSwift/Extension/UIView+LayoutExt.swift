//
//  UIView.swift
//  FinstroPay
//
//  Created by sondang on 5/4/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension UIView {
    
    var isShow: Bool {
        get {
            return !isHidden
        }
        set(newValue) {
            isHidden = !newValue
        }
    }
    
    // updated version of setDefaultStyle
    func drawCornerView(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func dropButtonSearchShadow() {
        let layer = self.layer
        layer.cornerRadius = 7
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowColor = UIColor(red:0.05, green:0, blue:0.2, alpha:0.5).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 16
        self.clipsToBounds = false
    }
    
    func dropDarkShadow() {
        dropShadow(alpha: 0.1)
    }
    
    func dropShadow(alpha: CGFloat) {
        let layer = self.layer
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor(red:0.05, green:0, blue:0.2, alpha:alpha).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        self.clipsToBounds = false
    }
    
    func removeShadow() {
        self.layer.shadowOpacity = 0
    }
    
    func viewCornerAndShadow() {
        self.drawCornerView()
        self.dropDarkShadow()
    }
    
    func addFullConstraintTo(view: UIView) {
        let lead: NSLayoutConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trail: NSLayoutConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let top: NSLayoutConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottom: NSLayoutConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraints([lead, trail, top, bottom])
    }
    
    func drawCorner(_ corner: UIRectCorner, cornerRadius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corner,
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
    }
    
}
