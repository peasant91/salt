//
//  ColorCode.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import UIKit

struct ColorCode<Base> {
    let base: Base
    
    init (_ base: Base) {
        self.base = base
    }
}

protocol ColorCodeCompatible {
    associatedtype ColorCodeType
    static var ex: ColorCode<ColorCodeType>.Type { get }
}

extension ColorCodeCompatible {
    static var ex: ColorCode<Self>.Type {
        return ColorCode<Self>.self
    }
}

extension UIColor: ColorCodeCompatible { }

extension ColorCode where Base: UIColor {
    
    static var secondary: UIColor {
        return UIColor(hex: "242E3B")
    }
    
    static var orange: UIColor {
        return UIColor(hex: "fdb71b")
    }
    
    static var promotion: UIColor {
        return UIColor(hex: "D44C00", alpha: 1)
    }
    
    static var promotionLight: UIColor {
        return UIColor(hex: "FF9900", alpha: 1)
    }
    
    static var freeOngkir: UIColor {
        return UIColor(hex: "149200", alpha: 1)
    }
    
    static var freeOngkirLight: UIColor {
        return UIColor(hex: "1CC700", alpha: 1)
    }
    
    static var darkOrange: UIColor {
        return UIColor(hex: "ff9d00")
    }
    
    static var yellow: UIColor {
        return UIColor(hex: "fdb920")
    }
    
    static var red: UIColor {
        return UIColor(hex: "FF6969")
    }
    
    static var green: UIColor {
        return UIColor(hex: "00E864")
    }
    
    static var gray: UIColor {
        return UIColor(hex: "D5D5D5")
    }
    
    static var black: UIColor {
        return UIColor(hex: "383838")
    }
    
    static var umkm: UIColor {
        return UIColor(hex: "45BAC1")
    }
    
    static var mahaMall: UIColor {
        return UIColor(hex: "00D2A0")
    }
    
    static var darkGray: UIColor {
        return UIColor(hex: "323232")
    }
    
    static var lightGray: UIColor {
        return UIColor(hex: "9e9d9d")
    }
    
    static var blue: UIColor {
        return UIColor(hex: "00A2E9", alpha: 1)
    }
    
    static var darkBlue: UIColor {
        return UIColor(hex: "006D9D", alpha: 1)
    }
    
    static var lightBlue: UIColor {
        return UIColor(hex: "0091C7")
    }
    
    static var lightMarketplace: UIColor {
        return UIColor(hex: "24C6FA", alpha: 1)
    }
    
    static var lightBlueAlpha: UIColor {
        return UIColor(hex: "E2F6FF")
    }
    
    static var notificationIcon: UIColor {
        return UIColor(hex: "0091C7", alpha: 0.5)
    }
    
    static var notificationErrorIcon: UIColor {
        return UIColor(hex: "FF8385", alpha: 0.1)
    }
    
    static var chatBg: UIColor {
        return UIColor(hex: "E8FAFF")
    }
    
    static var lineColor: UIColor {
        return UIColor(hex: "F4F4F6")
    }
    
    static var bg: UIColor {
        return UIColor(hex: "ededed")
    }
    
    static var error: UIColor {
        return UIColor(hex: "ffd1cc")
    }
    
    static var info: UIColor {
        return UIColor(hex: "918c6c")
    }
    
    static var bgInfo: UIColor {
        return UIColor(hex: "f6f4e8")
    }
    
    static var errorLabel: UIColor {
        return UIColor(hex: "342928")
    }
    
    static var completed: UIColor {
        return UIColor(hex: "2B88E8")
    }
    
    static var paid: UIColor {
        return UIColor(hex: "83C9FF")
    }
    
    static var canceled: UIColor {
        return UIColor(hex: "E92719")
    }
    
    static var confirmed: UIColor {
        return UIColor(hex: "8FCB89")
    }
    
    static var pending: UIColor {
        return UIColor(hex: "FDB71C")
    }
    
    static var searchBg: UIColor {
        return UIColor(hex: "727C8E").withAlphaComponent(0.1)
    }
    
    static var messageColor: UIColor {
        return UIColor(hex: "78849E")
    }
    
    static var disabledVoucher: UIColor {
        return UIColor(hex: "E6E6E6")
    }
    
    static var orderStatusBlue: UIColor {
        return UIColor(hex: "D8F1FF", alpha: 1)
    }
    
    static var orderStatusRed: UIColor {
        return UIColor(hex: "E80000F", alpha: 0.2)
    }
    
    static var yellowRating: UIColor {
        return UIColor(hex: "FEC200", alpha: 1)
    }
    
    static var yellowWarning: UIColor {
        return UIColor(hex: "FFF7E5", alpha: 1)
    }
    
    static var mainWarning: UIColor {
        return UIColor(hex: "CD7B2E", alpha: 1)
    }
    
    static var yellowWarningLine: UIColor {
        return UIColor(hex: "FCB61C", alpha: 1)
    }
    
    static var neutral40: UIColor {
        return UIColor(hex: "C6CBD4", alpha: 1)
    }
    
    static var colorMPBackground: UIColor {
        return UIColor(hex: "abe0f7", alpha: 1)
    }

}
