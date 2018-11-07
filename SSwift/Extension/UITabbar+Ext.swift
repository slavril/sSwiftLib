//
//  UITabbar+Ext.swift

//
//  Created by sondang on 5/17/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        
        var sizeThatFits = super.sizeThatFits(size)
        if #available(iOS 11.0, *) {
            sizeThatFits.height = window.safeAreaInsets.bottom + 60
        } else {
            // Fallback on earlier versions
            sizeThatFits.height = 70
        }
        
        return sizeThatFits
    }
    
}
