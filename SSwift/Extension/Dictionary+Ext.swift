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
        
        guard let db = dict[key] as? NSNumber else {
            return 0
        }
        
        return db.floatValue
    }
    
    func int(_ key: String) -> Int {
        var dict = self as! [String:Any]
        
        guard let db = dict[key] as? NSNumber else {
            return 0
        }
        
        return db.intValue
    }
    
    func dictionary(_ key: String) -> [String:Any]? {
        let dict = self as! [String:Any]
        
        guard let rDict = dict[key] as? [String:Any] else {
            return nil
        }
        
        return rDict
    }
    
}

extension Array where Element: Comparable {
    
    func isSame(as other: [Element]) -> Bool {
        let a = self.sorted()
        let b = other.sorted()
        return self.count == other.count && a == b
    }
    
}
