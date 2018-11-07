//
//  STextField.swift
//  FinstroPay
//
//  Created by sondang on 10/3/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

protocol AdvanceTextFieldDelegate: class {
    
    func advanceTextFieldDidTouchBackward(textfield: AdvanceTextField)
    
}

class AdvanceTextField: UITextField {
    
    var isPasteAvailable: Bool = true
    weak var advanceDelegate: AdvanceTextFieldDelegate?
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) && isPasteAvailable == false {
            return isPasteAvailable
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        
        if advanceDelegate != nil {
            advanceDelegate!.advanceTextFieldDidTouchBackward(textfield: self)
        }
    }
    
}

@objc protocol STextFieldDelegate {
    
    @objc optional func sTextBeginEditing(_ textfield: STextField)
    @objc optional func sTextEndEditing(_ textfield: STextField)
    @objc optional func sTextDidChange(_ textField: STextField)
    @objc optional func sTextDidTouchPostButton(_ textField: STextField, button: UIButton)
    @objc optional func sTextShouldChange(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
}

class STextField: SView {

    // MARK: Outlet
    
    @IBOutlet weak var textField: AdvanceTextField!
    @IBOutlet private weak var prefixButton: UIButton!
    @IBOutlet private weak var postfixButton: UIButton!
    @IBOutlet private weak var backView: UIView!
    @IBOutlet fileprivate weak var leadingTextfieldConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingTextfieldConstraint: NSLayoutConstraint!
    
    // MARK: Variables
    
    private var isSecure = false
    private var hasPostfixButton = false
    //default color
    private var highlightedBorderColor = Constant.color.main
    private var normalBorderColor = Constant.color.lightGray
    private var errorBorderColor = Constant.color.red
    private var beforeText: String = ""
    
    @IBInspectable
    public var corner: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set(value) {
            layer.cornerRadius = value
            backView.layer.cornerRadius = layer.cornerRadius
        }
    }
    
    @IBInspectable
    public var highlightColor: UIColor {
        get {
            return highlightedBorderColor
        }
        
        set(value) {
            highlightedBorderColor = value
        }
    }
    
    @IBInspectable
    public var normalColor: UIColor {
        get {
            return normalBorderColor
        }
        
        set(value) {
            normalBorderColor = value
        }
    }
    
    @IBInspectable
    public var errorColor: UIColor {
        get {
            return errorBorderColor
        }
        
        set(value) {
            errorBorderColor = value
        }
    }
    
    @IBInspectable
    public var isPasteAllowed: Bool {
        get {
            return textField.isPasteAvailable
        }
        set(value) {
            textField.isPasteAvailable = value
        }
    }
    
    @IBInspectable
    public var placeHolder: String {
        get {
            return textField.placeholder!
        }
        
        set(value) {
            textField.placeholder = value
        }
    }
    
    public var text: String {
        get {
            return textField.text!
        }
        
        set(value) {
            textField.text = value
        }
    }
    
    @IBInspectable
    public var maxLength = 0

    weak var delegate: STextFieldDelegate?
    
    public var length: Int { return textField.text!.count }
    
    // MARK: System methods
    
    override func nibName() -> String {
        return "CustomTextField"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.backgroundColor = Constant.color.lightGray
        backView.layer.borderColor = normalColor.cgColor
        backView.layer.borderWidth = 1
        backView.layer.cornerRadius = Constant.cornerRadius
        
        textField.delegate = self
        textField.advanceDelegate = self
        textField.setDefaultFont(16)
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func highlighted(_ highlighted: Bool) {
        if highlighted {
            backView.layer.borderColor = highlightedBorderColor.cgColor
        }
        else {
            backView.layer.borderColor = normalBorderColor.cgColor
        }
    }
    
    public func styleColor(highlight: UIColor?, normal: UIColor?, error: UIColor?) {
        if highlight != nil {
            highlightedBorderColor = highlight!
        }
        
        if normal != nil {
            normalBorderColor = normal!
        }
        
        if error != nil {
            errorBorderColor = error!
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    // MARK: - Support methods
    func setPlaceholder(_ placeHolder: String) {
        textField.placeholder = placeHolder
    }
    
    // upgrade functions for postfix button
    func addPostfixButton(title: String?, image: UIImage? = nil) {
        hasPostfixButton = true
        if let _image = image {
            postfixButton.setImage(_image, for: .normal)
        }
        
        if let _title = title {
            postfixButton.setTitle(_title, for: .normal)
        }
        
        if title != nil || image != nil {
            trailingTextfieldConstraint.priority = UILayoutPriority(250)
            postfixButton.addTargetClosure { [weak self] (button) in
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.handlePostButton(button: button)
            }
        }
        else {
            trailingTextfieldConstraint.priority = UILayoutPriority(990)
        }
        
    }
    
    func setPrefixImage(_ image: UIImage?) {
        if image != nil {
            prefixButton.setImage(image, for: .normal)
            leadingTextfieldConstraint.priority = UILayoutPriority(250)
        }
        else {
            leadingTextfieldConstraint.priority = UILayoutPriority(990)
        }
    }
    
    func setPostfixTintColor(_ color: UIColor) {
        postfixButton.tintColor = color
    }
    
    func setPostfixImage(_ image: UIImage?) {
        addPostfixButton(title: nil, image: image)
    }
    
    private func showUnhideButton(_ show: Bool) {
        postfixButton.isShow = show
        if show {
            trailingTextfieldConstraint.priority = UILayoutPriority(250)
        }
        else {
            trailingTextfieldConstraint.priority = UILayoutPriority(990)
        }
    }
    
    private func addUnhideButton() {
        hasPostfixButton = true
        showUnhideButton(false)
        postfixButton.setTitle("unhide", for: .normal)
        postfixButton.setTitleColor(Constant.color.gray, for: .normal)
        postfixButton.titleLabel?.captionStyle()
        postfixButton.addTargetClosure { [weak self] (button) in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.handleHideButton(sender: button)
        }
    }
    
    func setKeyboardType(type: UIKeyboardType) {
        textField.keyboardType = type
        if self.textField.isFirstResponder {
            textField.resignFirstResponder()
            textField.becomeFirstResponder()
        }
    }
    
    private func togglePasswordVisibility() {
        if isSecure {
            if let textRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument) {
                textField.replace(textRange, withText: textField.text!)
            }
        }
    }
    
    func setSecure() {
        isSecure = true
        textField.isSecureTextEntry = true
        addUnhideButton()
    }
    
    private func handlePostButton(button: UIButton) {
        if delegate != nil && delegate!.sTextDidTouchPostButton != nil {
            delegate!.sTextDidTouchPostButton!(self, button: button)
        }
    }
    
    @IBAction private func handleHideButton(sender: UIButton) {
        if sender.title(for: .normal) == "hide" {
            sender.setTitle("unhide", for: .normal)
            self.textField.isSecureTextEntry = true
        }
        else {
            sender.setTitle("hide", for: .normal)
            self.textField.isSecureTextEntry = false
        }
        
        togglePasswordVisibility()
    }
    
    func reset() {
        textField.text = ""
    }
    
    // override if need
    func textFieldDidChange(textfield: STextField) {}
}

// MARK: - AdvanceTextFieldDelegate

extension STextField: AdvanceTextFieldDelegate {
    
    func advanceTextFieldDidTouchBackward(textfield: AdvanceTextField) {
        if text.isEmpty && beforeText.isEmpty {
            textFieldDidChange(textfield)
        }
        
        if !beforeText.isEmpty {
            beforeText = ""
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension STextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        highlighted(true)
        //funAnimate()
        
        if delegate != nil {
            delegate!.sTextBeginEditing?(self)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        highlighted(false)
        
        if delegate != nil {
            delegate!.sTextEndEditing?(self)
        }
    }
    
    private func updateHideButtonLayout() {
        showUnhideButton(hasPostfixButton)
        
        if isSecure {
            showUnhideButton(isSecure && !text.isEmpty)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textFieldDidChange(textfield: self)
        
        updateHideButtonLayout()
        
        if delegate != nil && delegate?.sTextDidChange != nil {
            delegate?.sTextDidChange?(self)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let _text = textField.text else {
            return false
        }
        
        beforeText = _text
        var available = true
        let replacement = _text.replace(in: range, with: string)
        
        if maxLength > 0 && replacement.count > maxLength && replacement.count > _text.count {
            available = false
        }
        
        // check if method is exist
        if delegate != nil && delegate?.sTextShouldChange != nil {
            available = (delegate?.sTextShouldChange?(textField, shouldChangeCharactersIn: range, replacementString: string))!
        }
        
        if !available {
            if delegate != nil && delegate?.sTextDidChange != nil {
                delegate?.sTextDidChange?(self)
            }
        }
        
        return available
    }
    
}


// MARK: - Cursor control

extension STextField {
    
    private func getCurrentCursorPosition() -> Int {
        if let selectedRange = textField.selectedTextRange {
            let cursorPosition = textField.offset(from: textField.beginningOfDocument, to: selectedRange.start)
            return cursorPosition
        }
        
        return 0
    }
    
    private func selectAllText() {
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }
    
    private func selectText(from: Int, to: Int) {
        let startPosition = textField.position(from: textField.beginningOfDocument, offset: from)
        let endPosition = textField.position(from: textField.beginningOfDocument, offset: to)
        
        if startPosition != nil && endPosition != nil {
            textField.selectedTextRange = textField.textRange(from: startPosition!, to: endPosition!)
        }
    }
    
    private func moveCursorToEnd() {
        let newPosition = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
    }
    
    private func moveCursorToBegin() {
        let newPosition = textField.beginningOfDocument
        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
    }
    
    private func moveCursor(to index: Int) {
        if let position = textField.position(from: textField.beginningOfDocument, offset: index) {
            textField.selectedTextRange = textField.textRange(from: position, to: position)
        }
    }
    
}

