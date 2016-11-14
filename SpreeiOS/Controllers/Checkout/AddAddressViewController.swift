//
//  AddAddressViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 20/07/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class AddAddressViewController: BaseViewController {

    var order = Order.currentOrder!

    var editInProgress: AddressType?
    var useBillingAsShippingAddress = true

    @IBOutlet weak var billingAddressNameLabel: UILabel!
    @IBOutlet weak var billingAddressLine1Label: UILabel!
    @IBOutlet weak var billingAddressLine2Label: UILabel!
    @IBOutlet weak var billingAddressPhoneLabel: UILabel!
    @IBOutlet weak var billingAddressView: UIView!

    @IBOutlet weak var shippingAddressNameLabel: UILabel!
    @IBOutlet weak var shippingAddressLine1Label: UILabel!
    @IBOutlet weak var shippingAddressLine2Label: UILabel!
    @IBOutlet weak var shippingAddressPhoneLabel: UILabel!
    @IBOutlet weak var shippingAddressCheckboxButton: UIButton!
    @IBOutlet weak var shippingAddressView: UIView!

    @IBAction func editBillingAddress(_ sender: UIButton) {
        editInProgress = AddressType.billingAddress
        performSegue(withIdentifier: "selectAddress", sender: sender)
    }

    @IBAction func editShippingAddress(_ sender: UIButton) {
        editInProgress = AddressType.shippingAddress
        performSegue(withIdentifier: "selectAddress", sender: sender)
    }

    @IBAction func toggleShippingAddressCheckbox(_ sender: UIButton) {
        useBillingAsShippingAddress = !useBillingAsShippingAddress
        setStateForShippingAddressCheckbox()
    }

    @IBAction func updateAddress(_ sender: UIButton) {
        var data = URLRequestParams()

        data["order[bill_address_id]"] = order.billingAddress.id! as AnyObject?
        data["order[ship_address_id]"] = order.shippingAddress.id! as AnyObject?

        OrderApiClient.updateOrder(order.id, data: data, success: { order in
            CheckoutApiClient.next(order.id, success: { order in
                Order.currentOrder = order

                self.moveToNextCheckoutStep()
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
            })
        }, failure: { apiError in
            self.showApiErrorAlert(apiError)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fillBillingAndShippingAddress()
        setStateForShippingAddressCheckbox()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectAddress" {
            if let controller = segue.destination as? SelectAddressViewController {
                if let addressType = editInProgress {
                    switch addressType {
                    case .billingAddress:
                        controller.selectedAddress = order.billingAddress
                    case .shippingAddress:
                        controller.selectedAddress = order.shippingAddress
                    }
                }
            }
        }
    }

    @IBAction func unwindToAddAddressViewController(_ segue: UIStoryboardSegue){
        if let controller = segue.source as? SelectAddressViewController {
            if let address = controller.selectedAddress {
                if let editInProgress = editInProgress {
                    switch editInProgress {
                    case .billingAddress:
                        order.billingAddress = address

                        if useBillingAsShippingAddress {
                            order.shippingAddress = address
                        }
                    case .shippingAddress:
                        order.shippingAddress = address
                    }

                    fillBillingAndShippingAddress()
                }
            }
        }
    }

    private

    func fillBillingAndShippingAddress() {
        self.billingAddressNameLabel.text = order.billingAddress.fullName()
        self.billingAddressLine1Label.text = order.billingAddress.addressLine1()
        self.billingAddressLine2Label.text = order.billingAddress.addressLine2()
        self.billingAddressPhoneLabel.text = order.billingAddress.phoneNumber()

        self.shippingAddressNameLabel.text = order.shippingAddress.fullName()
        self.shippingAddressLine1Label.text = order.shippingAddress.addressLine1()
        self.shippingAddressLine2Label.text = order.shippingAddress.addressLine2()
        self.shippingAddressPhoneLabel.text = order.shippingAddress.phoneNumber()
    }

    func setStateForShippingAddressCheckbox() {
        if useBillingAsShippingAddress {
            let image = UIImage(named: "CheckFilled")
            shippingAddressCheckboxButton.setImage(image, for: UIControlState())

            shippingAddressView.isHidden = true

            order.shippingAddress = order.billingAddress
        } else {
            let image = UIImage(named: "CheckUnfilled")
            shippingAddressCheckboxButton.setImage(image, for: UIControlState())

            shippingAddressView.isHidden = false
        }
    }
}
