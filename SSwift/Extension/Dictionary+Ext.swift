//
//  Dictionary+Ext.swift

//
//  Created by sondang on 5/4/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension Dictionary {
    
    func bool(_ key:String) -> Bool! {
        var dict = self as! [String:Any]
        
        guard let tmp = dict[key] as? Bool else {
            return false
        }
        
        return tmp
    }
    
    func string(_ key:String) -> String! {
        var dict = self as! [String:Any]
        
        guard let tmp = dict[key] as? String else {
            return ""
        }
        
        return tmp
    }
    
    func date(_ key: String) -> Date! {
        var dict = self as! [String:Any]
        
        guard let db = dict[key] as? Double else {
            return Date()
        }
        
        return Date.dateFromInterval(db)
    }
    
    func float(_ key: String) -> Float {
        var dict = self as! [String:Any]
        
        if let value = dict[key] as? Float {
            return value
        }
        
        if let value = Float(dict[key] as? String ?? "0") {
            return value
        }
        
        return 0
    }
    
    func int(_ key: String) -> Int {
        var dict = self as! [String:Any]
        
        if let value = dict[key] as? Int {
            return value
        }
        
        if let value = Int(dict[key] as? String ?? "0") {
            return value
        }
        
        return 0
    }
    
    func dictionary(_ key: String) -> [String:Any]? {
        let dict = self as! [String:Any]
        
        guard let rDict = dict[key] as? [String:Any] else {
            return nil
        }
        
        return rDict
    }
    
    static func test() {
        if ["key": 10].int("key") == 10 && ["key": "10"].int("key") == 10 {
            print("Int: Success [10]")
        }
        else {
            print("Int: Fail [10]")
        }
        
        if ["key": 10.5].float("key") == 10.5 && ["key": "10.5"].float("key") == 10.5 {
            print("Float: Success [10.5]")
        }
        else {
            print("Float: Fail [10.5]")
        }
        
        if ["key": true].bool("key") == true {
            print("Float: Success [true]")
        }
        else {
            print("Float: Fail [true]")
        }
    }
    
}

extension Array where Element: Comparable {
    
    func isSame(as other: [Element]) -> Bool {
        let a = self.sorted()
        let b = other.sorted()
        return self.count == other.count && a == b
    }
    
}
