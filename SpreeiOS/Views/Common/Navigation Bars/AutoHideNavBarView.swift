//
//  NavBarView.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 19/10/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class AutoHideNavBarView: UIView {

    var primaryNavBar: UIView?
    var secondaryNavBar: UIView?

    var lastScrollPosition: CGFloat = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configure() {
        addPrimaryNavBar()
        addSecondaryNavBar()
    }

    //TODO
    override func layoutSubviews() {
        super.layoutSubviews()

        self.frame = CGRect(x: 0, y: 20, width: superview!.bounds.width, height: 44)

        primaryNavBar?.frame = CGRect(x: 0, y: 0, width: superview!.bounds.width, height: 44)
        secondaryNavBar?.frame = CGRect(x: 0, y: 44, width: superview!.bounds.width, height: 44)
    }

    func scrollTo(position: CGFloat) {
        let difference = position - lastScrollPosition

        if difference >= 5 {
            scrollToSecondaryNavBar()
        } else if difference <= -5 {
            scrollToPrimaryNavBar()
        } else {
            moveBy(distance: 0.5 * difference)
        }

        lastScrollPosition = position
    }

    func scrollToPrimaryNavBar() {
        moveTo(y: 0)
    }

    func scrollToSecondaryNavBar() {
        moveTo(y: 44)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.clipsToBounds && !self.isHidden && self.alpha > 0 {
            for subview in self.subviews.reversed() {
                let subPoint = subview.convert(point, from:self);

                if let result = subview.hitTest(subPoint, with:event) {
                    return result;
                }
            }
        }

        return nil
    }

    private

    func addPrimaryNavBar() {
        if let primaryNavBar = primaryNavBar {
            addSubview(primaryNavBar)
        }
    }

    func addSecondaryNavBar() {
        if let secondaryNavBar = secondaryNavBar {
            addSubview(secondaryNavBar)
        }
    }

    func moveBy(distance: CGFloat) {
        let y = self.bounds.origin.y
        let newY = y + distance

        if (newY >= 0 && newY <= 44) {
            moveTo(y: newY)
        }
    }

    func moveTo(y: CGFloat) {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.bounds = CGRect(x: 0, y: y, width: self.bounds.width, height: self.bounds.height)
        }, completion: nil)
    }
}
