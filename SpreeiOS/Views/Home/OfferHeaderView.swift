//
//  OfferHeaderView.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 18/10/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class OfferHeaderView: UIView {

    let height = 40
    var label = UILabel()
    var button = UIButton()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        customizeAppearance()

        addOfferLabel()
        addViewAllButton()
    }

    override func layoutSubviews() {
        let width = superview!.bounds.width
//        let height = CGFloat(height)

        self.frame = CGRect(x: 0, y: 0, width: Int(width), height: height)
        label.frame = CGRect(x: 10, y: 8, width: 150, height: 24)
        button.frame = CGRect(x: width - 80, y: 8, width: 70, height: 24)
    }

    func viewAll() {
        print("TBD - View all pressed")
    }

    private

    func customizeAppearance() {
        self.backgroundColor = UIColor.clear
    }

    func addOfferLabel() {
        label.font = UIFont(name: "Helvetica-Bold", size: 13)
        label.textColor = UIColor.black
        label.textAlignment = .left

        addSubview(label)
    }

    func addViewAllButton() {
        button.backgroundColor = UIColor.primary

        button.setTitle("View All", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)

        button.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 14)

        button.addTarget(self, action: #selector(viewAll), for: .touchUpInside)

        button.layer.cornerRadius = 5

        addSubview(button)
    }

}
