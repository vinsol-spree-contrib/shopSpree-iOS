//
//  ProductProperty.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 24/06/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import SwiftyJSON

class ProductProperty {
    var id: Int?
    var name: String?
    var value: String?

    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["presentation"].stringValue
        self.value = json["value"].stringValue
    }
}
