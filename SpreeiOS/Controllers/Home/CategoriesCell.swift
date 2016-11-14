//
//  CategoriesCell.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 03/09/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class CategoriesCell: UITableViewCell {

    let taxonomies = ["Fashion", "Electronics", "Mobile", "Lifestyle", "More"]

    let stackView = UIStackView()

    override func awakeFromNib() {
        super.awakeFromNib()

        addStackView()
        addStackViewConstraints()
    }

    func configure() {
        buildTaxonomiesStack()
    }

    private

    func addStackView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing

        contentView.addSubview(stackView)
    }

    func addStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let margins = contentView.layoutMarginsGuide
        stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 4).isActive = true
        stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 4).isActive = true

        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func buildTaxonomiesStack() {
        for taxonomy in taxonomies {
            let view = TaxonomyView()

            view.configure(type: taxonomy)
            view.addGestureRecognizer(tapGestureRecognizer())

            stackView.addArrangedSubview(view)
        }
    }

    func tapGestureRecognizer() -> UITapGestureRecognizer {
        let tableView = self.superview?.superview as! UITableView
        let controller = tableView.delegate as! HomeViewController

        let tapGestureRecognizer = UITapGestureRecognizer(target: controller, action: #selector(controller.navigateToProducts))
        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.delegate = self

        return tapGestureRecognizer
    }

}
