//
//  ProductRatingView.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 10/11/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

protocol ProductRatingViewDelegate {
    func didClickRatingButton()
}

class ProductRatingView: UIView {

    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()

    let color = UIColor(red: 77/255, green: 177/255, blue: 104/255, alpha: 1)

    var delegate: ProductRatingViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.white

        addImageView()
        addRatingLabel()
        addButton()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 60, height: 24)
    }

    func setRating(text: String) {
        self.label.text = text
    }

    func didClickRatingButton() {
        delegate?.didClickRatingButton()
    }

    private

    func addImageView() {
        imageView.image = UIImage(named: "RatingStarUnfilled")

        imageView.frame = CGRect(x: 5, y: 2, width: 20, height: 20)

        addSubview(imageView)
    }

    func addRatingLabel() {
        label.textColor = color
        label.font = UIFont(name: "Helvetica Bold", size: 16)

        label.frame = CGRect(x: 30, y: 2, width: 28, height: 20)

        addSubview(label)
    }

    func addButton() {
        button.layer.cornerRadius = 5
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 1

        button.addTarget(self, action: #selector(didClickRatingButton), for: .touchUpInside)

        button.frame = CGRect(x: 0, y: 0, width: 60, height: 24)

        addSubview(button)
    }
}
