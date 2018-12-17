//
//  UIStoryboard.swift

//
//  Created by sondang on 5/7/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static func storyboardFromName(_ name: String) -> UIStoryboard {
        return  UIStoryboard(name: name, bundle: nil)
    }
    
}
