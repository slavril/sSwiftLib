//
//  sto.swift
//  FinstroPay
//
//  Created by sondang on 6/5/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static func onboardingStoryBoard() -> UIStoryboard {
        return UIStoryboard.storyboardFromName(name: "OnBoarding")
    }
    
    static func paymentStoryBoard() -> UIStoryboard {
        return UIStoryboard.storyboardFromName(name: "Payment")
    }
    
    static func shoppingStoryBoard() -> UIStoryboard {
        return UIStoryboard.storyboardFromName(name: "Shopping")
    }
    
    static func settingStoryBoard() -> UIStoryboard {
        return UIStoryboard.storyboardFromName(name: "Setting")
    }
    
    static func informationStoryBoard() -> UIStoryboard {
        return UIStoryboard.storyboardFromName(name: "Information")
    }
    
}
