//
//  Variant.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 21/11/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import SwiftyJSON

class Variant {

    var id: Int?
    var sku: String?
    var name: String?
    var price: String?
    var isMaster = false
    var optionsText = ""

    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.sku = json["sku"].stringValue
        self.name = json["name"].stringValue
        self.price = json["display_price"].stringValue
        self.isMaster = json["is_master"].boolValue
        self.optionsText = json["options_text"].stringValue
    }

}
