//
//  TableViewLoadingCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 31/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class TableViewLoadingCell: UITableViewCell {
    let identifier = "LoadingCell"

    let activitySpinner = UIActivityIndicatorView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(style: .default, reuseIdentifier: identifier)

        addActivitySpinner()
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
