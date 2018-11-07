//
//  SView.swift
//  FinstroPay
//
//  Created by sondang on 10/3/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

class SView: UIView {
    
    @IBOutlet var contentView: UIView!
    var refreshControl: UIRefreshControl?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInt()
    }
    
    convenience init(viewFrame: CGRect) {
        self.init(frame: viewFrame)
        
        commonInt()
    }
    
    convenience init(frameForNoti: CGRect) {
        self.init(frame: frameForNoti)
    }
    
    func commonInt() {
        Bundle.main.loadNibNamed(nibName(), owner:self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds;
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    // MARK: - functional
    public func nibName() -> String {
        return self.className
    }
    
    func addToWindow() {
        let windows = UIApplication.shared.keyWindow!
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        windows.addSubview(self)
        windows.bringSubview(toFront: self)
    }
    
    func addContentView() {
        contentView = UINib.init(nibName: nibName(), bundle: nil).instantiate(withOwner: self, options: nil).last as! UIView
        contentView.frame = self.frame
        
        self.addSubview(contentView)
        self.addToWindow()
    }
    
    func getPullDownRefresh() -> UIRefreshControl {
        if refreshControl == nil {
            refreshControl = UIRefreshControl()
        }
        
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        
        return refreshControl!
    }
    
    @objc func refresh(sender:AnyObject) {}
    
}


/*
 
 // MARK: - grandient view
 private var gradientLayer: CAGradientLayer!
 
 @IBInspectable var topColor: UIColor = .clear {
 didSet {
 setNeedsLayout()
 }
 }
 
 @IBInspectable var bottomColor: UIColor = .clear {
 didSet {
 setNeedsLayout()
 }
 }
 
 @IBInspectable var startPointX: CGFloat = 0 {
 didSet {
 setNeedsLayout()
 }
 }
 
 @IBInspectable var startPointY: CGFloat = 0 {
 didSet {
 setNeedsLayout()
 }
 }
 
 @IBInspectable var endPointX: CGFloat = 0 {
 didSet {
 setNeedsLayout()
 }
 }
 
 @IBInspectable var endPointY: CGFloat = 0 {
 didSet {
 setNeedsLayout()
 }
 }
 
 @IBInspectable var cornerRadius: CGFloat = 0 {
 didSet {
 setNeedsLayout()
 }
 }
 
 @IBInspectable var shadowColor: UIColor = .clear {
 didSet {
 setNeedsLayout()
 }
 }
 
 @IBInspectable var shadowX: CGFloat = 0 {
 didSet {
 setNeedsLayout()
 }
 }
 
 @IBInspectable var shadowY: CGFloat = 0 {
 didSet {
 setNeedsLayout()
 }
 }
 
 @IBInspectable var shadowBlur: CGFloat = 0 {
 didSet {
 setNeedsLayout()
 }
 }
 
 override class var layerClass: AnyClass {
 return CAGradientLayer.self
 }
 
 override func layoutSubviews() {
 super.layoutSubviews()
 
 self.gradientLayer = self.layer as! CAGradientLayer
 self.gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
 self.gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
 self.gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
 self.layer.cornerRadius = cornerRadius
 self.layer.shadowColor = shadowColor.cgColor
 self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
 self.layer.shadowRadius = shadowBlur
 self.layer.shadowOpacity = 1
 }
 
 func animate(duration: TimeInterval, newTopColor: UIColor, newBottomColor: UIColor) {
 let fromColors = self.gradientLayer?.colors
 let toColors: [AnyObject] = [ newTopColor.cgColor, newBottomColor.cgColor]
 self.gradientLayer?.colors = toColors
 let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
 animation.fromValue = fromColors
 animation.toValue = toColors
 animation.duration = duration
 animation.isRemovedOnCompletion = true
 animation.fillMode = kCAFillModeForwards
 animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
 self.gradientLayer?.add(animation, forKey:"animateGradient")
 }
 
 
 */
