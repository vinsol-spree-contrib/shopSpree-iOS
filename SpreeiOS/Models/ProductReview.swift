//
//  ProductReview.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 23/06/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import SwiftyJSON

class ProductReview {
    var id: Int?
    var userId: Int?
    var userName: String?
    var title: String?
    var rating: Int?
    var review: String?

    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.userId = json["user_id"].intValue
        self.userName = json["name"].stringValue
        self.title = json["title"].stringValue
        self.rating = json["rating"].intValue
        self.review = json["review"].stringValue
    }

}
