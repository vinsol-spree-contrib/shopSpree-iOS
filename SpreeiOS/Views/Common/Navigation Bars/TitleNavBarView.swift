//
//  TitleNavBarView.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 20/10/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

protocol TitleNavBarViewDelegate {
    func didGoBack()
}

class TitleNavBarView: UIView {

    let titleLabel = UILabel()
    let backButton = UIButton()

    var delegate: TitleNavBarViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(frame: CGRect.zero)

        customizeAppearance()

        addTitleLabel()
        addBackButton()
    }

    override func layoutSubviews() {
        self.frame = CGRect(x: 0, y: 0, width: superview!.bounds.width, height: 44)
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.sizeToFit()
    }

    func hideBackButton() {
        backButton.isHidden = true
    }

    func didGoBack() {
        delegate?.didGoBack()
    }

    private

    func customizeAppearance() {
        self.backgroundColor = UIColor.primary
    }

    func addTitleLabel() {
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center

        titleLabel.font = UIFont(name: "Helvetica Bold", size: 16)

        addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func addBackButton() {
        backButton.setImage(UIImage(named: "Back"), for: .normal)
        backButton.setImage(UIImage(named: "Back"), for: .highlighted)

        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)

        backButton.addTarget(self, action: #selector(didGoBack), for: .touchUpInside)
        
        addSubview(backButton)
    }
}
