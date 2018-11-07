//
//  Constant.swift
//
//  Created by sondang on 5/3/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

enum UIUserInterfaceIdiom : Int {
    case Unspecified
    case Phone
    case Pad
}

// MARK: - ScreenSize
struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

// MARK: - DeviceType
struct DeviceType {
    static let iphone35  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let iphone40          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let iphone47          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let iphone55         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let ipad              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

// MARK: - Constant
class Constant: NSObject {
    
    static let shared = Constant()
    private override init() { }
    
    static let cornerRadius:CGFloat = 7
    static let defaultDateTimeFormat = "dd/MM/yyyy hh:mm:ss"
    static let serverDateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let dateTimeDisplayFormat = "EEE, dd MMM"
    
    // navigation controller
    var rootNavigationController: UINavigationController?
    var onBoardNavigationController: UINavigationController?
    
    // storyboard
    let onBoardingStoryboard = UIStoryboard(name: "OnBoarding", bundle: nil)
    
    // Support screen
    static let SCREEN_SIZE = UIScreen.main.bounds
    
    // session time out
    static var timeoutInSeconds: Int = (30 * 60)
    
    // MARK: - Size
    struct size {
        static let keyboardHeight: CGFloat = 224.0
        static let screenWidth = UIScreen.main.bounds.size.width
        static let screenHeight = UIScreen.main.bounds.size.height
        static let screen = UIScreen.main.bounds
    }
    
    // MARK: - Color
    struct color {
        static let disableButton = UIColor(rgb: 0xb9b4c3)
        static let mainHighlighted = UIColor(rgb: 0xa98cff)
        static let mainBackground = grayBackground
        static let main = UIColor(rgb: 0x4000ff)
        static let white = UIColor.white
        static let black = UIColor(red:1, green:1, blue:1, alpha:1)
        static let blackHalfOpacity = UIColor(red:1, green:1, blue:1, alpha:0.5)
        static let orange = UIColor(red:1, green:0.75, blue:0, alpha:1)
        static let red = UIColor(rgb: 0xff0048)
        static let lightGray = UIColor(rgb: 0xf8f7f9)
        static let disableGray = UIColor(rgb: 0xdfdfdf)
        static let gray = UIColor(rgb: 0x928DA4)
        static let darkGray = UIColor(rgb: 0x857f99)
        static let grayBackground = UIColor(rgb: 0xf2f2f3)
        static let grayD8 = UIColor(rgb: 0xD8D8D8)
        static let green = UIColor(rgb: 0x00d3a7)
    }
    
}
