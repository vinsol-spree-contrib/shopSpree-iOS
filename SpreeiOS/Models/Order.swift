//
//  Order.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 28/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import SwiftyJSON

class Order: NSObject, NSCoding {
    enum State {
        case cart
        case address
        case payment
        case complete
    }

    var id: String!
    var state: State = .cart
    var date: String!
    var item_total: String!
    var shipment_total: String!
    var tax_total: String!
    var promo_total: String!
    var total: String!

    var billingAddress: Address!
    var shippingAddress: Address!

    var card: Card?

    var lineItems = [LineItem]()

    var itemsCount: Int {
        return lineItems.count
    }

    init(fromJSON json: JSON) {
        self.id = json["id"].stringValue
        self.date = json["completed_at"].stringValue
        self.item_total = json["item_total"].stringValue
        self.shipment_total = json["shipment_total"].stringValue
        self.tax_total = json["additional_tax_total"].stringValue
        self.promo_total = json["promo_total"].stringValue
        self.total = json["total"].stringValue

        self.billingAddress = Address(fromJSON: json["bill_address"])
        self.shippingAddress = Address(fromJSON: json["ship_address"])

        for lineItemJSON in json["line_items"].arrayValue {
            let lineItem = LineItem(fromJSON: lineItemJSON)

            self.lineItems.append(lineItem)
        }

        switch json["state"].stringValue {
        case "address": self.state = .address
        case "payment": self.state = .payment
        case "complete": self.state = .complete
        default: self.state = .cart
        }
    }

    // Mark :- NSCoding
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String
        date = aDecoder.decodeObject(forKey: "date") as? String
        total = aDecoder.decodeObject(forKey: "total") as? String
        lineItems = aDecoder.decodeObject(forKey: "lineItems") as! [LineItem]
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(total, forKey: "total")
        aCoder.encode(lineItems, forKey: "lineItems")
    }

    // MARK:- Current Order / Cart

    static var _currentOrder: Order!

    static var currentOrder: Order? {
        get {
            if (_currentOrder != nil) {
                return _currentOrder
            } else {
                let defaults = UserDefaults.standard
                if let unarchivedObject = defaults.object(forKey: "currentOrder") as? NSData {
                    _currentOrder = NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? Order
                    return _currentOrder
                }
                return nil
            }
        }

        set {
            _currentOrder = newValue
            let defaults = UserDefaults.standard

            if let order = newValue {
                let archivedObject = NSKeyedArchiver.archivedData(withRootObject: order)
                defaults.set(archivedObject, forKey: "currentOrder")
            } else {
                defaults.removeObject(forKey: "currentOrder")
            }
        }
    }

    static var hasCurrentOrder: Bool {
        return currentOrder != nil && currentOrder!.id != ""
    }

    var isEmpty: Bool {
        return lineItems.count == 0
    }

    func formattableDate() -> NSDate {
        let formatter = DateFormatter()

        // 2016-08-11T12:29:13.800Z
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"

        return formatter.date(from: date)! as NSDate
    }

}

