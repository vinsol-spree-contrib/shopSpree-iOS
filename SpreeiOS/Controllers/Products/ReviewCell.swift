//
//  ReviewCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 23/06/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(forProductReview review: ProductReview) {
        self.titleLabel.text = review.title

        if let userName = review.userName {
            self.userLabel.text = "by \(userName)"
        } else {
            self.userLabel.text = "by Anonymous"
        }

        self.reviewLabel.text = review.review

        for rating in (1...review.rating!) {
            let starImageView = self.ratingView.subviews[rating - 1] as! UIImageView
            starImageView.image = UIImage(named: "RatingStarFilled")
        }
    }
}
