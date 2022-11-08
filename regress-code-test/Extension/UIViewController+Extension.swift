//
//  Storyboard+Extension.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func instantiateStoryboard() -> UIViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
    
    static func instantiateStoryboard(name: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
    
    static func instantiateStoryboard(bundle: Bundle?) -> UIViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: bundle)
        return storyboard.instantiateInitialViewController()!
    }
}

