//
//  UIButton+Ext.swift
//  FinstroPay
//
//  Created by sondang on 5/8/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

typealias UIButtonTargetClosure = (UIButton) -> Void

class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

extension UIButton {
    
    //MARK: Thriift customize
    func setOnboardingFloatButtonStyle() {
        self.layer.cornerRadius = Constant.cornerRadius
        self.setTitle("", for: .normal)
        self.floatButtonDisable()
    }
    
    func setLineButtonStyle(WithTitle title: String) {
        self.backgroundColor = UIColor.clear
        self.setTitle(title, for: .normal)
        self.setTitleColor(Constant.color.main, for: .normal)
    }
    
    func floatButtonDisable() {
        self.isEnabled = false
        self.setImage(UIImage(named: "icon_arrow_black_toright"), for: .disabled)
        self.tintColor = Constant.color.white
        self.backgroundColor = Constant.color.disableButton
        self.removeShadow()
    }
    
    func floatButtonEnable() {
        self.isEnabled = true
        self.setImage(UIImage(named: "icon_arrow_black_toright"), for: .normal)
        self.tintColor = Constant.color.main
        self.backgroundColor = Constant.color.white
        self.dropDarkShadow()
    }
    
    func floatButtonState(_ enabled: Bool) {
        if enabled {
            floatButtonEnable()
        }
        else {
            floatButtonDisable()
        }
    }
    
    func setGrayButtonStyle() {
        self.drawCornerView()
        self.setTitleColor(Constant.color.black, for: .normal)
        self.backgroundColor = Constant.color.lightGray
    }
    
    func setWhiteButtonStyle() {
        self.drawCornerView()
        self.setTitleColor(Constant.color.black, for: .normal)
        self.setTitleColor(Constant.color.gray, for: .disabled)
        self.backgroundColor = Constant.color.white
        self.titleLabel?.subHeaderSemiStyle()
    }
    
    func setClearButtonStyle() {
        self.setTitleColor(Constant.color.white, for: .normal)
        self.backgroundColor = UIColor.clear
        self.titleLabel?.subHeaderSemiStyle()
    }
    
    func disable() {
        self.setTitleColor(Constant.color.gray, for: .disabled)
        self.isEnabled = false
    }
    
    func enable() {
        self.isEnabled = true
    }
    
    func setPlaceHolder(_ text: String) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(Constant.color.gray, for: .normal)
    }
    
    func style(with title: String, titleColor: UIColor = Constant.color.white, backgroundColor: UIColor = Constant.color.main, corner: CGFloat = 0) {
        setTitleColor(titleColor, for: .normal)
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = corner
    }
    
}

// MARK: - finstro float button style
extension UIButton {
    
    func sFloatButtonStyle(icon: UIImage = UIImage(named: "icon_arrow_black_toright")!) {
        self.layer.cornerRadius = Constant.cornerRadius
        self.setTitle("", for: .normal)
        self.setImage(icon, for: .disabled)
        self.setImage(icon, for: .normal)
        self.sFloatButtonDisable()
    }
    
    func sFloatButtonDisable() {
        self.isEnabled = false
        self.tintColor = Constant.color.white
        self.backgroundColor = Constant.color.disableButton
        self.removeShadow()
    }
    
    func sFloatButtonEnable() {
        self.isEnabled = true
        self.tintColor = Constant.color.main
        self.backgroundColor = Constant.color.white
        self.dropDarkShadow()
    }
    
}

// MARK: - button-self handle
extension UIButton {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTargetClosure(closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
    
}
