//
//  NSNotificationCenter+Ext.swift
//  FinstroPay
//
//  Created by sondang on 5/3/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension NotificationCenter {
    
    static func addObserver(_ observer: Any, selector aSelector: Selector, name:String, object anObject:Any?) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: name), object: anObject)
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: NSNotification.Name(rawValue: name), object: anObject)
    }
    
    static func postNotification(aName:String, object anObject:Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: aName), object: anObject)
    }
    
    static func removeObserver(_ observer:Any) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func removeAllObserver() {
        removeObserver(self)
    }
    
}
