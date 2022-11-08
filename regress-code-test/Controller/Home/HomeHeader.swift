//
//  HomeHeader.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import UIKit

class HomeHeader: UIView {

    @IBOutlet weak var homeDescLabel: BaseLabel! {
        didSet {
            self.homeDescLabel.text = String(format: "home_desc".localized, User.shared.email() ?? "")
        }
    }
    
    var doLogout: (() -> Void)?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func logoutButtonTouchUpInside(_ sender: Any) {
        self.doLogout?()
    }
}
