//
//  Address.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 25/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import SwiftyJSON

enum AddressType {
    case billingAddress
    case shippingAddress
}

class Address {

    var id: Int?
    var firstName: String?
    var lastName: String?
    var phone: String?
    var company: String?
    var address1: String?
    var address2: String?
    var city: String?
    var stateName: String?
    var stateID: Int?
    var countryID: Int?
    var zipcode: String?

    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.firstName = json["firstname"].stringValue
        self.lastName = json["lastname"].stringValue
        self.phone = json["phone"].stringValue
        self.company = json["company"].stringValue
        self.address1 = json["address1"].stringValue
        self.address2 = json["address2"].stringValue
        self.city = json["city"].stringValue
        self.stateName = json["state_name"].stringValue
        self.stateID = json["state_id"].intValue
        self.countryID = json["country_id"].intValue
        self.zipcode = json["zipcode"].stringValue
    }

    func fullName() -> String {
        return "\(firstName!) \(lastName!)"
    }

    func addressLine1() -> String {
        if address1 != nil && address2 != nil {
            return "\(address1!), \(address2!) "
        } else if address1 != nil {
            return address1!
        } else if address2 != nil {
            return address2!
        } else {
            return ""
        }
    }

    func addressLine2() -> String {
        return "\(city!), \(stateName!), \(zipcode!)"
    }

    func phoneNumber() -> String {
        return phone!
    }
}

extension Address: Equatable { }

func ==(lhs: Address, rhs: Address) -> Bool {
    return lhs.id == rhs.id
}

