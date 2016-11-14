//
//  StaticNavBarView.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 24/10/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class StaticNavBarView: UIView {

    var navBar: UIView?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configure() {
        addNavBar()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.frame = CGRect(x: 0, y: 20, width: superview!.bounds.width, height: 44)

        navBar?.frame = CGRect(x: 0, y: 0, width: superview!.bounds.width, height: 44)
    }

    private

    func addNavBar() {
        if let navBar = navBar {
            addSubview(navBar)
        }
    }
}
