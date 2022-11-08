//
//  HomeTableViewCell.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
