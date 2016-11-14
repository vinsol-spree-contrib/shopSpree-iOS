//
//  CardCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 30/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cardTypeImage: UIImageView!
    @IBOutlet weak var defaultCardImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        cardView.layer.cornerRadius = 10
        cardView.layer.borderWidth = 0.5
        cardView.layer.borderColor = UIColor.black.cgColor
    }

    func configure(forCard card: Card) {
        self.numberLabel.text = card.lastDigits
        self.dateLabel.text = card.expiryDate

        if let card_type = card.type {
            self.cardTypeImage.image = UIImage(named: card_type)
        }

        if !card.isDefault! {
            self.defaultCardImage.removeFromSuperview()
        }
    }
}
