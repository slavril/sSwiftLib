//
//  String+Ext.swift

//
//  Created by sondang on 5/4/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension String {
    
    var first: Unicode.Scalar? {
        return unicodeScalars.first
    }
    
    func trimSpace() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func removeSpace() -> String {
        return removeStringContain(" ")
    }
    
    func removeStringContain(_ string: String) -> String {
        let string = String(self.filter({ !string.contains($0) }))
        return string
    }
    
    func rangeOf(_ string: String) -> NSRange {
        let cheat: NSString = self as NSString
        let range = cheat.range(of: string)
        return range
    }
    
    func replace(in range: NSRange, with replaceString: String) -> String {
        let oldStrVersion: NSString = self as NSString
        let result: String = oldStrVersion.replacingCharacters(in: range, with: replaceString)
        return result
    }
    
    func isCharacterOnly() -> Bool {
        let nonLetterSet = CharacterSet.letters.inverted
        if self.rangeOfCharacter(from: nonLetterSet) != nil {
            return false
        }
        
        return true
    }
    
    func isDigit() -> Bool {
        let nonDigit = CharacterSet.decimalDigits.inverted
        if self.rangeOfCharacter(from: nonDigit) != nil {
            return false
        }
        
        return true
    }
    
    // specify methods
    func isNumberAndContainOnlyOneChar() -> Bool {
        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        var counting: Int = 0
        
        for char in self.unicodeScalars {
            if letters.contains(char) {
                counting += 1
            }
            else if !digits.contains(char) {
                // it is not digit or char
                return false
            }
            
            if counting == 2 {
                return false
            }
        }
        
        if counting == 0 {
            return false
        }
        
        return true
    }
    
    func numberOfDigit() -> Int {
        var counting: Int = 0
        let digits = CharacterSet.decimalDigits
        for char in self.unicodeScalars {
            if digits.contains(char) {
                counting += 1
            }
        }
    
        return counting
    }
    
    func numberOfLetter() -> Int {
        var counting: Int = 0
        let letters = CharacterSet.letters
        for char in self.unicodeScalars {
            if letters.contains(char) {
                counting += 1
            }
        }
        
        return counting
    }
    
    struct NumFormatter {
        static let instance = NumberFormatter()
    }
    
    var floatValue: Float? {
        return NumFormatter.instance.number(from: self)?.floatValue
    }
    
    var doubleValue: Double? {
        return NumFormatter.instance.number(from: self)?.doubleValue
    }
    
    var integerValue: Int? {
        return NumFormatter.instance.number(from: self)?.intValue
    }
    
    // calculate height of text
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func formatNumberWith(matrix: [Int]) -> String {
        let m = matrix.reduce(0, +)
        if self.count > m {
            return self
        }
        
        var stringFormated: String = ""
        
        var index = 0
        var stage = 0
        for i in self.removeSpace() {
            stringFormated.append(i)
            if index == matrix[stage] - 1 {
                index = 0
                stage += 1
                stringFormated.append(" ")
            }
            else {
                index += 1
            }
        }
        
        return stringFormated.trimSpace()
    }
    
    func formatPhoneNumber() -> String {
        return formatNumberWith(matrix: [4, 3, 3])
    }
    
    func formatCardNumber() -> String {
        return formatNumberWith(matrix: [4, 4, 4, 4])
    }
    
    func toJson() -> [String:Any]? {
        let data = self.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String:Any] {
                return jsonArray
            } else {
                logPrint("bad json")
                return nil
            }
        } catch let error as NSError {
            logPrint(error.description)
            return nil
        }
    }
    
    func escape() -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        var escaped = ""
        if #available(iOS 8.3, *) {
            escaped = self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? self
        } else {
            let batchSize = 50
            var index = self.startIndex
            
            while index != self.endIndex {
                let startIndex = index
                let endIndex = self.index(index, offsetBy: batchSize, limitedBy: self.endIndex) ?? self.endIndex
                let range = startIndex..<endIndex
                let substring = self[range]
                
                escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)
                index = endIndex
            }
        }
        
        return escaped
    }
    
}
