//
//  UIView+FontExt.swift
//  FinstroPay
//
//  Created by sondang on 5/3/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

// font family
let openSansSemiBold: String = "OpenSans-SemiBold"
let openSansRegular: String = "OpenSans-Regular"
let openSansBold: String = "OpenSans-Bold"
let openSansLight: String = "OpenSans-Light"
let ORC: String = "OCRAExtended"
let VarelaRoundRegular: String = "VarelaRound-Regular"

extension UIView {
    
    func setFont(_ font: String, _ size: CGFloat) {
        if self is UILabel {
            let label = self as! UILabel
            label.font = UIFont(name: font, size: size)!
        }
        else if self is UIButton {
            let button = self as! UIButton
            button.titleLabel!.font = UIFont(name: font, size: size)!
        }
        else if self is UITextField {
            let textfield = self as! UITextField
            textfield.font = UIFont(name: font, size: size)!
        }
    }
    
    //MARK: custom warhead
    func setLightFont(_ size: CGFloat) {
        self.setFont(openSansLight, size)
    }
    
    func setDefaultFont(_ size: CGFloat) {
        self.setFont(openSansRegular, size)
    }
    
    func setBoldFont(_ size: CGFloat) {
        self.setFont(openSansBold, size)
    }
    
    func setSemiBoldFont(_ size: CGFloat) {
        self.setFont(openSansSemiBold, size)
    }
    
    func updateFontSize(_ size: Float) {
        
    }
    
    func setORCFont(_ size: CGFloat) {
        self.setFont(ORC, size)
    }
    
    func setVarelaFont(_ size: CGFloat) {
        self.setFont(VarelaRoundRegular, size)
    }
    
    static func semiBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: openSansSemiBold, size: size)!
    }
    
    static func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: openSansRegular, size: size)!
    }
    
    static func boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: openSansBold, size: size)!
    }
    
}
