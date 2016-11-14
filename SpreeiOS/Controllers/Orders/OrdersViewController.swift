//
//  OrdersViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 28/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class OrdersViewController: BaseViewController {

    var isLoading = true
    var orders = [Order]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false

        fetchOrders()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "orderDetail" {
            if let controller = segue.destination as? OrderDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    controller.order = orders[(indexPath as NSIndexPath).row]
                }
            }
        }
    }

}

private extension OrdersViewController {

    func fetchOrders() {
        OrderApiClient.orders({ orders in
                self.orders = orders
                self.isLoading = false
                self.tableView.reloadData()
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
        })
    }
}

extension OrdersViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return (isLoading ? 1 : orders.count)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isLoading {
            return nil
        } else {
            let order = orders[section]

            let formatter = DateFormatter()
            formatter.dateFormat = "EEE, MMM dd"

            let orderDate = formatter.string(from: order.formattableDate() as Date)

            return "\(orderDate) (ID: \(order.id!))"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isLoading ? 1 : orders[section].lineItems.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            return TableViewLoadingCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
            let order = orders[indexPath.section]
            let lineItem = order.lineItems[(indexPath as NSIndexPath).row]

            cell.configure(forLineItem: lineItem)

            return cell
        }
    }

}

extension OrdersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isLoading {
            return 0
        } else {
            return 20
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (isLoading ? 0 : 10)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLoading {
            return tableView.bounds.height
        } else {
            return 88
        }
    }
}
