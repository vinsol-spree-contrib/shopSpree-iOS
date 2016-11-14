//
//  ProductNavBarView.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 20/10/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

protocol ProductNavBarViewDelegate {
    func didSortProducts()
    func didFilterProducts()
    func didChangeProductView(to: Product.View)
}

class ProductNavBarView: UIView {

    var currentProductView = Product.View.List

    let viewButton = UIButton()
    let sortButton = UIButton()
    let filterButton = UIButton()


    var delegate: ProductNavBarViewDelegate?

    init() {
        super.init(frame: CGRect.zero)

        customizeAppearance()

        addViewButton()
        addSortButton()
        addFilterButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        viewButton.frame = CGRect(x: 0, y: 0, width: 50, height: 44)

        let sortButtonWidth = (self.bounds.width - viewButton.bounds.width) / 2
        sortButton.frame = CGRect(x: 50, y: 0, width: sortButtonWidth, height: 44)
        filterButton.frame = CGRect(x: 50 + sortButtonWidth, y: 0, width: sortButtonWidth, height: 44)

        layer.addBorder(.top, color: UIColor.lightGray, thickness: 0.4)
        layer.addBorder(.bottom, color: UIColor.lightGray, thickness: 1)

        sortButton.layer.addBorder(.left, color: UIColor.lightGray, thickness: 0.4)
        sortButton.layer.addBorder(.right, color: UIColor.lightGray, thickness: 0.4)
    }

    func didChangeView(sender: UIButton!) {
        toggleProductView()

        delegate?.didChangeProductView(to: currentProductView)
    }

    func didSortProducts() {
        delegate?.didSortProducts()
    }

    func didFilterProducts() {
        delegate?.didFilterProducts()
    }

    func toggleProductView() {
        switch currentProductView {
        case .List: setProductView(.Grid); break
        case .Grid: setProductView(.List); break
        }
    }

    private

    func customizeAppearance() {
        self.backgroundColor = UIColor.white
    }

    func addViewButton() {
        setProductView(.List)

        viewButton.addTarget(self, action: #selector(didChangeView), for: .touchUpInside)

        addSubview(viewButton)
    }

    func addSortButton() {
        sortButton.setTitle("Sort", for: .normal)
        sortButton.setTitleColor(UIColor.black, for: .normal)
        sortButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 14)

        sortButton.addTarget(self, action: #selector(didSortProducts), for: .touchUpInside)

        addSubview(sortButton)
    }

    func addFilterButton() {
        filterButton.setTitle("Filter", for: .normal)
        filterButton.setTitleColor(UIColor.black, for: .normal)
        filterButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 14)

        filterButton.addTarget(self, action: #selector(didFilterProducts), for: .touchUpInside)

        addSubview(filterButton)
    }

    func setProductView(_ productView: Product.View) {
        self.currentProductView = productView

        switch productView {
        case .List:
            self.viewButton.setImage(UIImage(named: "List"), for: .normal)
            break
        case .Grid:
            self.viewButton.setImage(UIImage(named: "Grid"), for: .normal)
            break
        }

    }

}
