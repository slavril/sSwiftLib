//
//  NSObject.swift

//
//  Created by sondang on 5/8/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension NSObject {
    
    func nameOfClass() -> String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    public var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
}
