//
//  BaseViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 24/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshCartItemBadgeCount()
    }

    func alert(message: String) {
        let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)

        ac.addAction(ok)

        present(ac, animated: true, completion: nil)
    }

    func refreshCartItemBadgeCount() {
        if let order = Order.currentOrder {
            if let controller = self.tabBarController {
                if let tabBarItems = controller.tabBar.items {
                    tabBarItems[1].badgeValue = "\(order.itemsCount)"
                }
            }
        }
    }

    func moveToNextCheckoutStep() {
        if let order = Order.currentOrder {
            switch order.state {
            case .cart:     break
            case .address:  moveToAddAddressStep()
            case .payment:  moveToAddPaymentStep()
            case .complete: moveToCompleteCheckout()
            }
        }
    }

    private

    func moveToAddAddressStep() {
        let checkoutAddAddress = self.storyboard?.instantiateViewController(withIdentifier: "checkoutAddAddress") as! AddAddressViewController

        self.navigationController?.pushViewController(checkoutAddAddress, animated: true)
    }

    func moveToAddPaymentStep() {
        let checkoutAddPayment = self.storyboard?.instantiateViewController(withIdentifier: "checkoutAddPayment") as! AddPaymentViewController

        self.navigationController?.pushViewController(checkoutAddPayment, animated: true)
    }

    func moveToCompleteCheckout() {
        let checkoutComplete = self.storyboard?.instantiateViewController(withIdentifier: "checkoutComplete") as! OrderCompleteViewController

        self.navigationController?.pushViewController(checkoutComplete, animated: true)
    }
}

extension BaseViewController {

    func showAlert(_ title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: handler)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }

    func showApiSuccessAlert(_ message: String) {
        showAlert("Yippiee!!!", message: message, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }

    func showApiErrorAlert(_ apiError: ApiError) {
        showAlert("Whooops!!!", message: apiError.errorMessage(), handler: nil)
    }


}
