//
//  Timer+Ext.swift

//
//  Created by sondang on 6/8/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension Timer {

    static func stop(timer: inout Timer?) {
        guard timer != nil else {
            return
        }
        
        timer!.invalidate()
        timer = nil
    }
    
}
