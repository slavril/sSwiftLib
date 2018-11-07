//
//  SNotificationObject.swift
//  SSwift
//
//  Created by sondang on 11/7/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

class SNotificationObject: SObject {

    private var _apsPayload: [String: Any]?
    
    var apsPayload: [String: Any]? {
        return _apsPayload
    }
    
    private var message: String?
    private var userInfo: [AnyHashable: Any]?
    
    var messageId: String = ""
    var payloadString: String?
    
    init(userInfo: [AnyHashable: Any]) {
        super.init()
        
        self.userInfo = userInfo
        _apsPayload = userInfo["aps"] as? [String: Any]
    }
    
}
