//
//  AddressCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 26/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    var checked = false

    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(forAddress address: Address) {
        self.nameTextLabel.text = address.fullName()
        self.address1Label.text = address.address1!
        self.address2Label.text = address.address2!
    }

}
