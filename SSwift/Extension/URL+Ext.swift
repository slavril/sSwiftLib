//
//  Url+Ext.swift

//
//  Created by sondang on 5/22/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension URL {

    func isExist() -> Bool {
        if self.absoluteString.count == 0 {
            return false
        }
        
        return UIApplication.shared.canOpenURL(self)
    }
    
    static func URLWithString(link: String?) -> URL? {
        if link != nil {
            let urlString = URL(string: link!)
            guard urlString != nil else {
                return nil
            }
            
            if link?.count != 0 {
                if urlString!.isExist() {
                    return urlString!
                }
                else if URL(string: "http://\(link!)")!.isExist() {
                    return URL(string: "http://\(link!)")
                }
            }
        }
        
        return nil
    }
    
}
