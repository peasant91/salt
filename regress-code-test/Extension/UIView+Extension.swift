//
//  UIView+Extension.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func loadNib<T : UIView>() -> T? {
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // xib not loaded, or it's top view is of the wrong type
            return nil
        }
        view.frame = bounds
        self.addSubview(view)
        return view
    }
    
    @discardableResult
    func loadNib<T : UIView>(bundle: Bundle?) -> T? {
        guard let view = bundle?.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        view.frame = bounds
        self.addSubview(view)
        return view
    }
}
