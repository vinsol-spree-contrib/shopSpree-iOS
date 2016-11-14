//
//  CartViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 07/06/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class CartViewController: BaseViewController {

    enum STATE {
        case Loading
        case Empty
        case Filled
    }

    var isLoading = true

    var order: Order?

    var currentState: STATE {
        if isLoading {
            return .Loading
        } else if order!.itemsCount == 0 {
            return .Empty
        } else {
            return .Filled
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutView: UIView!

    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!


    @IBAction func checkout(_ sender: UIButton) {
        if order!.state == .cart {
            CheckoutApiClient.next(order!.id, success: { order in
                    Order.currentOrder = order

                    self.moveToNextCheckoutStep()
                }, failure: { apiError in
                    self.showApiErrorAlert(apiError)
            })
        } else {
            self.moveToNextCheckoutStep()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        checkoutView.isHidden = true

        checkoutButton.layer.borderWidth = 0.5
        checkoutButton.layer.borderColor = UIColor.secondary.cgColor
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchCartDetails()

        self.tabBarController?.tabBar.isHidden = false
    }

    func refreshCartView() {
        self.order = Order.currentOrder

        self.tableView.reloadData()

        if currentState == .Filled {
            checkoutView.isHidden = false
        } else {
            checkoutView.isHidden = true
        }

        self.itemsCountLabel.text = "Total (\(order?.itemsCount ?? 0))"

        if let order = order {
            self.totalPriceLabel.text = "$ \(order.total!)"
        } else {
            self.totalPriceLabel.text = "$ 0.00"
        }

    }
}

private extension CartViewController {
    func fetchCartDetails() {
        OrderApiClient.current({ order in
                Order.currentOrder = order
                self.isLoading = false
                self.refreshCartView()
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }

    func removeLineItemFromCart(id: Int) {
        CartApiClient.removeLineItem(order!.id, lineItemID: id, success: { order in
                Order.currentOrder = order
                self.refreshCartView()
                self.refreshCartItemBadgeCount()
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }

    func changeQuantityForLineItem(id: Int, to qty: Int) {
        var data = URLRequestParams()

        data["line_item[quantity]"] = qty

        CartApiClient.updateLineItem(order!.id, lineItemID: id, data: data, success: { order in
                Order.currentOrder = order
                self.refreshCartView()
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }

}

extension CartViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentState {
        case .Loading:  return 1
        case .Empty:    return 1
        case .Filled:   return order!.lineItems.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch currentState {
        case .Loading:  return TableViewLoadingCell()
        case .Empty:    return EmptyCartCell()
        case .Filled:   return cartCell(for: indexPath)
        }

    }

    private

    func cartCell(for indexPath: IndexPath) -> CartCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell

        let lineItem = order!.lineItems[indexPath.row]

        cell.delegate = self

        cell.configure(forLineItem: lineItem)

        return cell
    }
}

extension CartViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch currentState {
        case .Loading:  return view.bounds.height - 108
        case .Empty:    return view.bounds.height - 108
        case .Filled:   return 120
        }
    }

}

extension CartViewController: CartCellDelegate {

    func removeLineItem(id: Int) {
        removeLineItemFromCart(id: id)
    }

    func changeQtyOfLineItem(id: Int, to qty: Int) {
        changeQuantityForLineItem(id: id, to: qty)
    }

}
