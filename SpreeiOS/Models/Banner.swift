//
//  Carousel.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 30/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import SwiftyJSON

class Banner {
    var id: Int?
    var name: String?
    var displayName: String?
    var imageURLs = [String]()

    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.displayName = json["presentation"].stringValue

        for banner in json["banners"].arrayValue {
            let imageURL = banner["image_url"].stringValue
            self.imageURLs.append(imageURL)
        }
    }
}
