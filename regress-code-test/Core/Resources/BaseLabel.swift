//
//  BaseLabel.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import UIKit

class BaseLabel: UILabel {
    
    var _text: String = ""
    
    required init() {
        super.init(frame: CGRect.zero)
        self.sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.sharedInit()
    }
    
    @IBInspectable var localizedText: String = "" {
        didSet {
            self._text = localizedText.localized
            self.buildView()
        }
    }
    
    func buildView() {
        self.text = self._text
    }
    
    func sharedInit() {
    }
}
