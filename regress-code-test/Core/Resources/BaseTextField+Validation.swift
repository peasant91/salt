//
//  BaseTextField+Validation.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
enum ValidationType: Int {
    case numeric
    case empty
    case emptyEmail
    case emptyPhone
    case emptyPassword
    case email
    case password
    case phone
    case minimum
    case credential
    case alphanumeric
    case address
    case match
    case optional
}

extension BaseTextField {

    func validate(type: [ValidationType]? = nil) -> Bool {
        
        var validationType: [ValidationType]
        if let _type = type {
            validationType = _type
        } else {
            validationType = self.validationTypes
        }
        
        var isValid = true
        
        for type in validationType {
            if !isValid { return false }
            switch type {
            case ValidationType.empty:
                if self.text!.isEmpty {
                    self.validationError(text: "\(self.localized.localized) \("kolom_ini_harus_diisi".localized)")
                    isValid = false
                }
                
            case ValidationType.numeric:
                if !self.text!.isNumeric {
                    self.validationError(text: "\(self.localized.localized) \("numeric_only".localized)")
                    isValid = false
                }
                
            case ValidationType.emptyEmail:
                if self.text!.isEmpty {
                    self.validationError(text: "empty_email".localized)
                    isValid = false
                }
                
            case ValidationType.emptyPhone:
                if self.text!.isEmpty {
                    self.validationError(text: "empty_credential".localized)
                    isValid = false
                }
            case ValidationType.emptyPassword:
                if self.text!.isEmpty {
                    self.validationError(text: "empty_password".localized)
                    isValid = false
                }
            case ValidationType.minimum:
                if self.text!.count < self.minimumCharacter && self.text!.count > 0 {
                    self.validationError(text: String(format: "minimal_karakter".localized, minimumCharacter))
                    isValid = false
                }
            case ValidationType.credential:
                if !self.text!.isPhoneNumber && !self.text!.isEmail {
                    self.validationError(text: "invalid_credentials".localized)
                    isValid = false
                }
            case ValidationType.email:
                if !self.text!.isEmpty && !self.text!.trim().isEmail {
                    self.validationError(text: "error_email".localized)
                    isValid = false
                }
            case ValidationType.phone:
//                if !self.text!.trimPhoneNumber().isPhoneNumber {
//                    self.validationError(text: "error_phone_number".localized)
                    isValid = false
//                }
            case ValidationType.alphanumeric:
                if !self.text!.isAlphanumeric {
                    self.validationError(text: "\(self.localized.localized) \("alphanumeric".localized)")
                    isValid = false
                }
            case .address:
                if !self.text!.isAddress {
                    self.validationError(text: "invalid_address".localized)
                    isValid = false
                }
            case ValidationType.match:
                if self.text! != self.matchingTextField.text!  {
                    self.validationError(text: "invalid_confirm_password".localized)
                    isValid = false
                }
            default:
                break
            }
        }
        
        if isValid {
            self.validationSuccess()
        }
        
        return isValid
        
    }
}
