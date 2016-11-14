//
//  CollectionViewLoadingCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 10/11/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class CollectionViewLoadingCell: UICollectionViewCell {
    let activitySpinner = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addActivitySpinner()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private

    func addActivitySpinner() {
        activitySpinner.color = UIColor.primary

        activitySpinner.startAnimating()

        contentView.addSubview(activitySpinner)

        activitySpinner.translatesAutoresizingMaskIntoConstraints = false

        activitySpinner.widthAnchor.constraint(equalToConstant: 24).isActive = true
        activitySpinner.heightAnchor.constraint(equalToConstant: 24).isActive = true

        activitySpinner.centerXAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor).isActive = true
        activitySpinner.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor).isActive = true
    }
}
