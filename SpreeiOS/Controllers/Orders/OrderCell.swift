//
//  OrderCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 28/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {


    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(forLineItem lineItem: LineItem) {
        nameLabel.text = lineItem.name
        qtyLabel.text = String(lineItem.qty!)

        if let urlString = lineItem.imageURL {
            if let url = URL(string: urlString) {
                itemImageView.loadImageWithURL(url)
            }
        }
    }

}
