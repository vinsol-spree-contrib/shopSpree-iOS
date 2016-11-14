//
//  AddPaymentViewController.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 21/07/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

class AddPaymentViewController: BaseViewController {

    enum PaymentMode {
        case none
        case creditCard
        case cashOnDelivery
    }

    var order = Order.currentOrder!

    var paymentMode = PaymentMode.none

    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var taxPriceLabel: UILabel!
    @IBOutlet weak var shipmentPriceLabel: UILabel!
    @IBOutlet weak var promoPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var creditCardButton: UIButton!
    @IBOutlet weak var cashOnDeliveryButton: UIButton!
    @IBOutlet weak var cardDetailsView: UIView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardExpiryDateLabel: UILabel!

    @IBAction func setCreditCardPaymentMode(_ sender: UIButton) {
        setPaymentMode(.creditCard)
    }

    @IBAction func setCashOnDeliveryPaymentMode(_ sender: UIButton) {
        setPaymentMode(.cashOnDelivery)
    }

    @IBAction func editCreditCard(_ sender: UIButton) {
        performSegue(withIdentifier: "selectCard", sender: sender)
    }

    @IBAction func completeOrder(_ sender: UIButton) {
        switch paymentMode {
        case .none:
            alert(message: "Please choose a payment method to complete your order.")
        case .creditCard:
            alert(message: "Pay via CC is not yet supported. Please use COD to complete your payment.")
        case .cashOnDelivery:
            capturePayment()
        }
    }

    func capturePayment() {
        var data = URLRequestParams()

        data["order[payments_attributes][][payment_method_id]"] = 2 as AnyObject?

        CheckoutApiClient.complete(order.id, data: data, success: { order in
            Order.currentOrder = order
            
            self.moveToNextCheckoutStep()
        }, failure: { apiError in
            self.showApiErrorAlert(apiError)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setPaymentMode(.none)

        fillInCardDetails()
        fillInPaymentDetails()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCard" {
            if let controller = segue.destination as? SelectCardViewController {
                if let card = order.card {
                    controller.selectedCard = card
                }
            }
        }
    }

    @IBAction func unwindToAddPaymentViewController(_ segue: UIStoryboardSegue){
        if let controller = segue.source as? SelectCardViewController {
            if let card = controller.selectedCard {
                order.card = card

                fillInCardDetails()
            }
        }
    }

    private

    func setPaymentMode(_ mode: PaymentMode) {
        let checkImage = UIImage(named: "CheckFilled")
        let uncheckImage = UIImage(named: "CheckUnfilled")

        switch mode {
        case .none:
            paymentMode = .none
            cardDetailsView.isHidden = true
            creditCardButton.setImage(uncheckImage, for: UIControlState())
            cashOnDeliveryButton.setImage(uncheckImage, for: UIControlState())
        case .creditCard:
            paymentMode = .creditCard
            cardDetailsView.isHidden = false
            creditCardButton.setImage(checkImage, for: UIControlState())
            cashOnDeliveryButton.setImage(uncheckImage, for: UIControlState())
        case .cashOnDelivery:
            paymentMode = .cashOnDelivery
            cardDetailsView.isHidden = true
            creditCardButton.setImage(uncheckImage, for: UIControlState())
            cashOnDeliveryButton.setImage(checkImage, for: UIControlState())
        }
    }

    func fillInCardDetails() {
        if let card = order.card {
            cardNumberLabel.text = "XXXX-XXXX-XXXX-\(card.lastDigits!)"
            cardExpiryDateLabel.text = "\(card.expiryDate!)"
        }
    }

    func fillInPaymentDetails() {
        itemPriceLabel.text = "$ \(order.item_total ?? "0")"
        taxPriceLabel.text = "$ \(order.tax_total ?? "0")"
        shipmentPriceLabel.text = "$ \(order.shipment_total ?? "0")"
        promoPriceLabel.text = "- $ \(order.promo_total ?? "0")"
        totalPriceLabel.text = "$ \(order.total ?? "0")"
    }
}
