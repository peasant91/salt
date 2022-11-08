//
//  BaseButton.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import UIKit
import SnapKit
import TransitionButton

class BaseButton: TransitionButton {
    
    var isLoading: Bool = false
    var masking: UIView?
    
    required init() {
        super.init(frame: CGRect.zero)
        self.layer.cornerRadius = 15
        
        self.backgroundColor = UIColor.clear
        self.setTitleColor(UIColor.ex.blue, for: .normal)
        self.snp.makeConstraints { (make) in
            make.height.equalTo(self.height)
        }

        sharedInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 15
        
        self.backgroundColor = UIColor.clear
        self.setTitleColor(UIColor.ex.blue, for: .normal)
        self.snp.makeConstraints { (make) in
            make.height.equalTo(self.height)
        }

        sharedInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.masking?.bounds = self.bounds
    }

    var disabled: Bool = false{
        didSet {
            self.isEnabled = !self.disabled
            self.masking?.isHidden = !self.disabled
            self.masking?.layoutIfNeeded()
        }
    }
    
    @IBInspectable var localized: String = "" {
        didSet {
            self.setTitle(self.localized.localized, for: .normal)
        }
    }
    
    @IBInspectable var fontSize: CGFloat = 17 {
        didSet {
            self.titleLabel?.font = UIFont(name: "SegoeUI", size: self.fontSize)
        }
    }
    
    @IBInspectable var isBold: Bool = false {
        didSet {
            if self.isBold {
                self.titleLabel?.font = UIFont(name: "SegoeUI-Bold", size: self.fontSize)
            }
        }
    }
    
    @IBInspectable var fontType: String = "" {
        didSet {
            let type = self.fontType.split(separator: "-")
            let isBold = type[0] == "bold"
            var fontSize: CGFloat = 17
            if type.count > 1 {
                fontSize = CGFloat(Int(type[1])!)
            }
            if (isBold) {
                self.titleLabel?.font = UIFont(name: "SegoeUI-Bold", size: fontSize)
            } else {
                self.titleLabel?.font = UIFont(name: "SegoeUI", size: fontSize)
            }
        }
    }

    @IBInspectable var height: Int = 48 {
        didSet {
            self.snp.updateConstraints { (make) in
                make.height.equalTo(self.height)
            }
//            self.layer.cornerRadius = CGFloat(height / 2)
        }
    }

    func sharedInit() {
        self.backgroundColor = UIColor.ex.secondary
        self.setTitleColor(UIColor.white, for: .normal)
    }
}
