//
//  UILabel+LayoutExt.swift

//
//  Created by sondang on 5/14/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

extension UILabel {
    
    func highlightText(text: String, color: UIColor) {
        highlightText(text: text, color: color, font: UIView.semiBoldFont(size: self.font.pointSize))
    }
    
    func highlightText(text: String, color: UIColor, font: UIFont) {
        highlightText(text: text, color: color, font: font, handler: nil)
    }
    
    func highlightText(text: String, color: UIColor, handler: (() -> Void)?) {
        highlightText(text: text, color: color, font: UIView.semiBoldFont(size: self.font.pointSize), handler: handler)
    }
    
    func highlightText(text: String, color: UIColor, font: UIFont, handler: (() -> Void)?) {
        let attributedString = NSMutableAttributedString(string: self.text!)
        let range = self.text!.lowercased().rangeOf(text.lowercased())
        if range.location != NSNotFound {
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIView.semiBoldFont(size: self.font.pointSize), range: range)
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        }
        
        self.attributedText = attributedString
        if handler != nil {
            let convertRect = boundingRectForCharacterRange(range: range)
            let button = UIButton.init(frame: convertRect)
            button.backgroundColor = UIColor.clear
            button.addTargetClosure { (button) in
                handler!()
            }
            
            self.addSubview(button)
            self.bringSubview(toFront: button)
        }
    }
    
    private func boundingRectForCharacterRange(range: NSRange) -> CGRect {
        //NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:[self attributedText]];
        let textStore = NSTextStorage.init(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager.init()
        textStore.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer.init(size: CGSize(width: self.bounds.size.width, height: self.attributedText!.height(withConstrainedWidth: self.bounds.size.width)))
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = 0
        layoutManager.addTextContainer(textContainer)
        var typhoRange: NSRange = NSRange.init()
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &typhoRange)

        return layoutManager.boundingRect(forGlyphRange: typhoRange, in: textContainer)
    }
    
    func setAmountWithCurrencyStyle(amount: Float) {
        let rangeOfAmount = self.text!.rangeOf(amount.amountString)
        if rangeOfAmount.location == NSNotFound {
            return
        }
        
        let amountText = NSMutableAttributedString.init(string: text!)
        
        // set the custom font and color for the 0,1 range in string
        var pointSize = font.pointSize
        if pointSize >= 12 {
            pointSize = pointSize/2
        }
        
        let _font = UIFont.init(name: font.fontName, size: pointSize)
        let begin = (rangeOfAmount.location + amount.amountString.count) - 2
        if _font != nil {
            amountText.setAttributes([.font: _font!], range: NSMakeRange(begin, 2))
            
            // set the attributed string to the UILabel object
            self.attributedText = amountText
        }
    }
    
    func underline(content: String) {
        let range = self.text!.rangeOf(content)
        if range.location == NSNotFound {
            return
        }
        
        var attributedString = NSMutableAttributedString(string: self.text!)
        if self.attributedText != nil {
            attributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        }
        
        attributedString.addAttributes([.underlineStyle: 1], range: range)
        self.attributedText = attributedString
    }

}
