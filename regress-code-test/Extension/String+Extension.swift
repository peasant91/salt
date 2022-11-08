//
//  String+Extension.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
//        if Config.shared.getLanguage() != "id" {
//            let path = Bundle.main.path(forResource: "en", ofType: "lproj")
//            let bundle = Bundle(path: path!)

        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
//        } else {
//            let path = Bundle.main.path(forResource: "id", ofType: "lproj")
//            let bundle = Bundle(path: path!)
//
//            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
//        }
//        return self
    }
    
    var isAlphanumeric: Bool {
        let regex = "^[a-zA-Z0-9_ ]*$"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    var isNumeric: Bool {
        let regex = "^[0-9]*$"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    var isAddress: Bool {
        let regex = "^[a-zA-Z0-9.,_' ]*$"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    var isPhoneNumber: Bool {
//        let regex = "^(\\+\(AppDelegate.countryCode)|0|1|2|3|4|5|6|7|8|9|\(AppDelegate.countryCode))([0-9]{9,14})"
//
//        let pred = NSPredicate(format:"SELF MATCHES %@", regex)
//        return pred.evaluate(with: self)
        return true
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func trim() -> String {
        return  self.trimmingCharacters(in: .whitespaces)
    }
    
    func convertHtml() -> NSAttributedString {
        let string = self.appending(String(format: "<style>body{font-family: '%@'; font-size:%fpx;}</style>", "SegoeUI", 12))
        guard let data = string.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    func size(font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
                return boundingBox.height
        }
    
    func truncate(_ length: Int, trailing: String = "…") -> String {
        (self.count > length) ? self.prefix(max(0, length - trailing.count)) + trailing : self
    }
}
