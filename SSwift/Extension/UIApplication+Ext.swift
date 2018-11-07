//
//  UIApplication+Ext.swift

//
//  Created by sondang on 6/15/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var topViewController: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    func getPresentedViewController() -> UIViewController? {
        var presentViewController = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentViewController?.presentedViewController {
            presentViewController = pVC
        }
        
        return presentViewController
    }
    
    static func getTopViewController() -> UIViewController? {
        let vc = UIApplication.shared.keyWindow?.rootViewController
        return vc
    }
    
}
