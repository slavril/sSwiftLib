//
//  SAuthenUtility.swift

//
//  Created by sondang on 9/26/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

class SKeyChainUtility {
    
    static func save(key: String, value: String, finished: (() -> ())?) {
        let passwordItem = KeychainPasswordItem(
            service: KeychainConfiguration.serviceName,
            account: key,
            accessGroup: KeychainConfiguration.accessGroup
        )
        do {
            try passwordItem.savePassword(value)
            if finished != nil {
                finished!()
            }
        } catch {
            
        }
    }
    
    static func load(key: String, finished:((_ properties: String?) -> ())?) {
        let passwordItem = KeychainPasswordItem(
            service: KeychainConfiguration.serviceName,
            account: key,
            accessGroup: KeychainConfiguration.accessGroup
        )
        do {
            let storedPassword = try passwordItem.readPassword()
            finished?(storedPassword)
        } catch {
            finished?(nil)
        }
    }
    
}

private struct KeychainConfiguration {
    
    static let serviceName = "SlavrilServiceName"
    
    /*
     Specifying an access group to use with `KeychainPasswordItem` instances
     will create items shared accross both apps.
     
     For information on App ID prefixes, see:
     https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/AppID.html
     and:
     https://developer.apple.com/library/ios/technotes/tn2311/_index.html
     */
    //    static let accessGroup = "[YOUR APP ID PREFIX].com.example.apple-samplecode.GenericKeychainShared"
    
    /*
     Not specifying an access group to use with `KeychainPasswordItem` instances
     will create items specific to each app.
     */
    static let accessGroup: String? = nil
    
}
