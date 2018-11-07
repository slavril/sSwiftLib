//
//  Float+FinstroPay.swift
//  FinstroPay
//
//  Created by sondang on 7/17/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension Float {
    
    var amountString: String {
        if self <= 0 {
            return "$0.00"
        }
        
        return String(format: "$%.2f", self)
    }
    
    var string: String {
        if self <= 0 {
            return "$0.00"
        }
        
        return String(format: "%.2f", self)
    }
    
    func round(UpNumberAfterDot number: Int) -> Float {
        var rountUpNumberAfterDot: Float = 1
        for _ in 1...number {
            rountUpNumberAfterDot = rountUpNumberAfterDot*10
        }
        
        return ceil(self * rountUpNumberAfterDot)/rountUpNumberAfterDot
    }
    
}
