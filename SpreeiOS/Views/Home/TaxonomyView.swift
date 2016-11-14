//
//  TaxonomyView.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 17/10/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class TaxonomyView: UIView {

    let width = 60
    let height = 48

    let imageWidth = 24
    let imageHeight = 24

    let labelWidth = 60
    let labelHeight = 16

    var label = UILabel()
    var imageView = UIImageView()

    init() {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)

        customizeAppearance()

        addTaxonNameLabel()
        addTaxonImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configure(type: String) {
        self.label.text = type

        self.imageView.image = UIImage(named: type)
    }

    private

    func customizeAppearance() {
        self.backgroundColor = UIColor.primary

        self.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        self.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }

    func addTaxonNameLabel() {
        label.frame = CGRect(x: (width - labelWidth) / 2, y: (height - labelHeight) - 2, width: labelWidth, height: labelHeight)
        label.font = UIFont(name: "Helvetica-Bold", size: 10)
        label.textColor = UIColor.white
        label.textAlignment = .center

        addSubview(label)
    }

    func addTaxonImageView() {
        imageView.frame = CGRect(x: (width - imageWidth) / 2, y: 2, width: imageWidth, height: imageHeight)

        addSubview(imageView)
    }

}
