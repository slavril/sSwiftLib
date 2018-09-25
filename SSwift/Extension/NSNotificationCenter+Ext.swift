//
//  NSNotificationCenter+Ext.swift
//  FinstroPay
//
//  Created by sondang on 5/3/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

enum NotificationCenterKey: String {
    case apnsReceived = "PushNotificationReceivedKey"
    case storePayLater = "StorePayLaterKey"
    case storePayNow = "StorePayNowKey"
    case virtualCardDeactivate = "virtualCardDeactivateKey"
    case needUpdateStoreLocation = "needUpdateStoreLocationKey"
    case appBecomeActive = "appBecomeActiveKey"
    case appWillForeground = "appWillForegroundKey"
    case updateAccount = "updatedUserProfileKey"
    case appTimeOut = "appTimeOut"
    case paymentSuccess = "paymentSuccess"
    case updatedPaymentMethods = "updatedPaymentMethods"
}

extension NotificationCenter {
    
    static func addObserver(_ observer: Any, selector aSelector: Selector, key: NotificationCenterKey) {
        addObserver(observer, selector: aSelector, name: key.rawValue, object: nil)
    }
    
    static func addObserver(_ observer: Any, selector aSelector: Selector, key: NotificationCenterKey, object anObject:Any?) {
        addObserver(observer, selector: aSelector, name: key.rawValue, object: anObject)
    }
    
    static func addObserver(_ observer: Any, selector aSelector: Selector, name:String, object anObject:Any?) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: name), object: anObject)
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: NSNotification.Name(rawValue: name), object: anObject)
    }
    
    static func postNotification(key: NotificationCenterKey, object anObject:Any?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: key.rawValue), object: anObject)
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
