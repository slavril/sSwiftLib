//
//  String+Localize.swift

//
//  Created by sondang on 5/4/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension String {
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        if let localShared = Bundle.localShared {
            return NSLocalizedString(self, tableName: tableName, bundle: localShared, value: "**\(self)**", comment: "")
        }
        
        return NSLocalizedString(self, tableName: "en", value: "**\(self)**", comment: "")
    }
    
    static func setLanguage(_ lang: String) {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        if path != nil {
            Bundle.localShared = Bundle(path: path!)
        }
    }
    
}

extension Bundle {
    
    static var localShared: Bundle?
    
}
