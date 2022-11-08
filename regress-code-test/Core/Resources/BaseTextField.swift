//
//  BaseTextField.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import SnapKit

protocol CredentialDelegate {
    func credentialCheckSuccess()
    func credentialCheckFailed()
}

class BaseTextField: SkyFloatingLabelTextField {
    
    // MARK: Properties
    
    private var onCredentialCheck: Bool = false
    private var credentialError: Bool = false
    
    var errorTextLabel: UILabel = UILabel()
    var notesTextLabel: BaseLabel?
    var hasError: Bool {
        get {
            if onCredentialCheck || credentialError {
                self.onCredentialCheck = false
                self.credentialError = false
                return true
            } else { return !validate() }
        }
    }
    var credentialDelegate: CredentialDelegate?
    
    // MARK: Validation Properties
    
    var validationTypes: [ValidationType] = [.optional]
    var minimumCharacter: Int = 0
    var maximumCharacter: Int = 500
    var matchingTextField: BaseTextField!
    var actionAvailable: Bool = true
    
    var notes: String? {
        didSet {
            self.setupTextFieldNotes()
            self.notesTextLabel?.text = self.notes
        }
    }
    

    // MARK: Initialize
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) ||
            action == #selector(UIResponderStandardEditActions.cut(_:)) {
            return actionAvailable
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.systemFont(ofSize: 14)
        self.titleFont = UIFont.systemFont(ofSize: 12)
        self.delegate = self
        
        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
        }
        self.autocorrectionType = .no

        setupTextField()
        setupErrorText()
    }
    
    @IBInspectable var addNotes: String = "" {
        didSet {
            self.notes = addNotes.localized
        }
    }
    
    @IBInspectable var height: Int = 50 {
        didSet {
            self.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(50)
            }
        }
    }
    
    @IBInspectable var kunci: UITextViewDelegate!
    
    @IBInspectable var localized: String = "" {
        didSet {
            self.title = self.localized.localized
            self.basePlaceholder = self.localized
        }
    }
    
    @IBInspectable var basePlaceholder: String = "" {
        didSet {
            self.placeholder = self.basePlaceholder.localized
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        // if no baseName hide title
        if self.localized != "" {
            setTitleVisible(true, animated: true, animationCompletion: nil)
        }
        placeholder = ""
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        setTitleVisible(false, animated: true, animationCompletion: nil)
        
        // hide title only show placeholder
        // if no text and baseName is empty, set placeholder to empty
        if self.text != "" && self.localized == "" {
            placeholder = ""
        } else {
            placeholder = self.basePlaceholder.localized
        }
        super.resignFirstResponder()
        return true
    }
    
    func validationError(text: String) {
        self.setError(text: text)
    }
    
    func validationSuccess() {
        self.clearError()
    }
    
    func credentialSuccess() {
        onCredentialCheck = false
        self.credentialError = false
        self.credentialDelegate?.credentialCheckSuccess()
    }
    
    func credentialFailure(_ text: String) {
        onCredentialCheck = false
        self.credentialError = true
        self.setError(text: text)
        self.credentialDelegate?.credentialCheckFailed()
    }
    
    func setError(text: String) {
        if self.notes != nil {
            self.notesTextLabel?.isHidden = true
        }
        
        self.errorTextLabel.text = text
        self.selectedLineColor = UIColor.ex.red
        self.selectedTitleColor = UIColor.ex.red
        self.lineColor = UIColor.ex.red
        self.titleColor = UIColor.ex.red
        self.placeholderColor = UIColor.ex.red
    }
    
    func clearError() {
        if self.notes != nil {
            self.notesTextLabel?.isHidden = false
        }
        
        self.errorTextLabel.text = ""
        self.selectedLineColor = UIColor.ex.blue
        self.selectedTitleColor = UIColor.ex.blue
        self.lineColor = UIColor.ex.blue
        self.titleColor = UIColor.ex.blue
        self.placeholderColor = UIColor.ex.blue
    }
    
    // MARK: Private Methods
    
    private func setupTextField() {
        self.lineHeight = 1
        self.selectedLineHeight = 1
        self.titleFormatter = { (text: String) in
            return text
        }
        
        self.lineColor = UIColor.ex.blue
        self.titleColor = UIColor.ex.blue
        self.selectedLineColor = UIColor.ex.blue
        self.selectedTitleColor = UIColor.ex.blue
        self.placeholderColor = UIColor.ex.blue
        self.textColor = UIColor.ex.black
        self.errorColor = UIColor.ex.red
    }
    
    private func setupTextFieldNotes() {
        self.notesTextLabel = BaseLabel()
        self.notesTextLabel?.font = UIFont.systemFont(ofSize: 12)
        self.notesTextLabel!.textColor = UIColor.ex.messageColor
        self.notesTextLabel!.textAlignment = .left
        self.notesTextLabel?.numberOfLines = 2
        self.notesTextLabel?.minimumScaleFactor = 0.5
        self.notesTextLabel?.adjustsFontSizeToFitWidth = true
        self.addSubview(self.notesTextLabel!)
        
        self.notesTextLabel!.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).offset(2)
            make.leading.equalTo(self.snp.leading).offset(0)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
    }
    
    private func setupErrorText() {
        self.errorTextLabel.numberOfLines = 1
        self.errorTextLabel.adjustsFontSizeToFitWidth = true
        self.notesTextLabel?.font = UIFont.systemFont(ofSize: 12)
        self.errorTextLabel.textColor = UIColor.ex.red
        self.errorTextLabel.textAlignment = .left
        self.addSubview(self.errorTextLabel)
        
        self.errorTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).offset(2)
            make.leading.equalTo(self.snp.leading).offset(0)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
    }
}


// MARK: Credential Validation

extension BaseTextField {
    func checkPhone() {
//        self.onCredentialCheck = true
//        _ = CredentialAPI().checkCredential(data: [
//            Constants.Parameter.phoneCode: 62,
//            Constants.Parameter.phone: self.text!
//        ]).subscribe { (response) in
//            print("SUCCESS")
//            self.credentialSuccess()
//        } onError: { (error) in
//            let _err = error as! ErrorModel
//            self.credentialFailure(_err.errors.first?.message ?? "")
//        } onCompleted: {
            self.onCredentialCheck = false
//        }
    }
    
    func checkEmail() {
//        if self.text!.isEmpty {
//            return
//        }
//
//        self.onCredentialCheck = true
//        _ = CredentialAPI().checkCredential(data: [
//            Constants.Parameter.email: self.text!
//        ]).subscribe { (response) in
//            self.credentialSuccess()
//        } onError: { (error) in
//            let _err = error as! ErrorModel
//            self.credentialFailure(_err.errors.first?.message ?? "")
//        } onCompleted: {
            self.onCredentialCheck = false
//        }
    }
}


// MARK: UITextFieldDelegate

extension BaseTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.clearError()
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= self.maximumCharacter
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
