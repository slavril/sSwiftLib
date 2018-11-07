//
//  Data.swift

//
//  Created by sondang on 6/25/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension Data {
    
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
    
}
