//
//  ProductPropertiesView.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 25/10/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class ProductPropertiesView: UIView {

    var properties = [ProductProperty]()

    var propertyCount: Int {
        return properties.count
    }

    var nameLabels = [UILabel]()
    var valueLabels = [UILabel]()

    var maxNameLabelWidth: CGFloat {
        return (nameLabels.map({ $0.bounds.width }).reduce(0, { max($0, $1) }))
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var propertiesStackView: UIStackView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup() {
        if propertyCount == 0 {
            self.isHidden = true
        } else {
            buildLabels()
            layoutLabels()
        }
    }

    private

    func buildNameLabel(for property: ProductProperty) -> UILabel {
        let label = UILabel()

        label.tag = 0
        label.font = UIFont(name: "Helvetica", size: 12)
        label.text = "\(property.name!): "
        label.numberOfLines = 1

        label.sizeToFit()

        return label
    }

    func buildValueLabel(for property: ProductProperty) -> UILabel {
        let label = UILabel()

        label.tag = 1
        label.font = UIFont(name: "Helvetica", size: 12)
        label.text = property.value
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        label.sizeToFit()

        return label
    }

    func buildDataRow(for index: Int) -> UIView {
        let row = UIView(frame: CGRect.zero)

        let nameLabel = nameLabels[index]
        let valueLabel = valueLabels[index]

        valueLabel.frame = CGRect(x: maxNameLabelWidth + 10,
                                  y: valueLabel.bounds.origin.x,
                                  width: valueLabel.bounds.width,
                                  height: valueLabel.bounds.height)

        row.addSubview(nameLabel)
        row.addSubview(valueLabel)

        row.translatesAutoresizingMaskIntoConstraints = false

        row.widthAnchor.constraint(equalToConstant: propertiesStackView.bounds.width).isActive = true

        row.heightAnchor.constraint(equalToConstant: valueLabel.bounds.height).isActive = true

        return row
    }

    func buildLabels() {
        for property in properties {
            let nameLabel = buildNameLabel(for: property)
            let valueLabel = buildValueLabel(for: property)

            nameLabels.append(nameLabel)
            valueLabels.append(valueLabel)
        }
    }

    func layoutLabels() {
        for index in 0..<properties.count {
            let row = buildDataRow(for: index)

            propertiesStackView.addArrangedSubview(row)
        }
    }

}
