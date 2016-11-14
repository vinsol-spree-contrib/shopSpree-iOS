//
//  RatingCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 24/06/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class RatingCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var ratingsCountLabel: UILabel!

    @IBOutlet weak var fiveRatingView: UIView!
    @IBOutlet weak var fiveRatingIndicatorLabel: UILabel!
    @IBOutlet weak var fiveRatingCountLabel: UILabel!

    @IBOutlet weak var fourRatingView: UIView!
    @IBOutlet weak var fourRatingIndicatorLabel: UILabel!
    @IBOutlet weak var fourRatingCountLabel: UILabel!

    @IBOutlet weak var threeRatingView: UIView!
    @IBOutlet weak var threeRatingIndicatorLabel: UILabel!
    @IBOutlet weak var threeRatingCountLabel: UILabel!

    @IBOutlet weak var twoRatingView: UIView!
    @IBOutlet weak var twoRatingIndicatorLabel: UILabel!
    @IBOutlet weak var twoRatingCountLabel: UILabel!

    @IBOutlet weak var oneRatingView: UIView!
    @IBOutlet weak var oneRatingIndicatorLabel: UILabel!
    @IBOutlet weak var oneRatingCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(forProduct product: Product) {
        titleLabel.text = product.name
        averageRatingLabel.text = "\(product.averageRating.roundToPlaces(1)) / 5"
        ratingsCountLabel.text = "from \(product.ratingsCount!) Customers"

        let label5 = indicatorLabel()
        label5.frame = CGRect(x: fiveRatingIndicatorLabel.frame.origin.x,
                              y: fiveRatingIndicatorLabel.frame.origin.y,
                              width: CGFloat(product.ratingsDistribution[5]! * Int(fiveRatingIndicatorLabel.frame.width) / product.ratingsCount!),
                              height: fiveRatingIndicatorLabel.frame.height)
        fiveRatingView.addSubview(label5)
        fiveRatingCountLabel.text = "\(product.ratingsDistribution[5]!)"


        let label4 = indicatorLabel()
        label4.frame = CGRect(x: fourRatingIndicatorLabel.frame.origin.x,
                              y: fourRatingIndicatorLabel.frame.origin.y,
                              width: CGFloat(product.ratingsDistribution[4]! * Int(fourRatingIndicatorLabel.frame.width) / product.ratingsCount!),
                              height: fourRatingIndicatorLabel.frame.height)
        fourRatingView.addSubview(label4)
        fourRatingCountLabel.text = "\(product.ratingsDistribution[4]!)"

        let label3 = indicatorLabel()
        label3.frame = CGRect(x: threeRatingIndicatorLabel.frame.origin.x,
                              y: threeRatingIndicatorLabel.frame.origin.y,
                              width: CGFloat(product.ratingsDistribution[3]! * Int(threeRatingIndicatorLabel.frame.width) / product.ratingsCount!),
                              height: threeRatingIndicatorLabel.frame.height)
        threeRatingView.addSubview(label3)
        threeRatingCountLabel.text = "\(product.ratingsDistribution[3]!)"

        let label2 = indicatorLabel()
        label2.frame = CGRect(x: twoRatingIndicatorLabel.frame.origin.x,
                              y: twoRatingIndicatorLabel.frame.origin.y,
                              width: CGFloat(product.ratingsDistribution[2]! * Int(twoRatingIndicatorLabel.frame.width) / product.ratingsCount!),
                              height: twoRatingIndicatorLabel.frame.height)
        twoRatingView.addSubview(label2)
        twoRatingCountLabel.text = "\(product.ratingsDistribution[2]!)"

        let label1 = indicatorLabel()
        label1.frame = CGRect(x: oneRatingIndicatorLabel.frame.origin.x,
                              y: oneRatingIndicatorLabel.frame.origin.y,
                              width: CGFloat(product.ratingsDistribution[1]! * Int(oneRatingIndicatorLabel.frame.width) / product.ratingsCount!),
                              height: oneRatingIndicatorLabel.frame.height)
        oneRatingView.addSubview(label1)
        oneRatingCountLabel.text = "\(product.ratingsDistribution[1]!)"
    }

    private

    func indicatorLabel() -> UILabel {
        let label = UILabel()

        label.backgroundColor = UIColor.orange

        return label
    }
}
