//
//  Product.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 28/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import SwiftyJSON

class Product {
    enum View {
        case List
        case Grid
    }

    var id: Int?
    var name: String?
    var description: String?
    var price: String?
    var variantId: Int?
    var thumbnailURL: String?
    var imageURL: String?
    var ratingsCount: Int?

    var ratingsDistribution = [Int: Int]()

    var averageRating: Double

    var imageURLs = [String]()

    var reviews = [ProductReview]()
    var properties = [ProductProperty]()

    var reviewsCount: Int {
        return reviews.count
    }

    var propertiesCount: Int {
        return properties.count
    }

    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.description = json["description"].stringValue
        self.price = json["display_price"].stringValue
        self.variantId = json["variants_including_master"][0]["id"].intValue
        
        if let imageURL = json["images"][0]["product_url"].rawString() {
            self.thumbnailURL = imageURL
        }

        self.ratingsCount = json["reviews_count"].intValue
        self.averageRating = json["avg_rating"].doubleValue

        for propertyJSON in json["product_properties"].arrayValue {
            let property = ProductProperty(fromJSON: propertyJSON)
            self.properties.append(property)
        }

        for imageJSON in json["images"].arrayValue {
            self.imageURLs.append(imageJSON["large_url"].stringValue)
        }

        for rating in (1...5) {
            self.ratingsDistribution[rating] = json["ratings_distribution"]["\(rating)"].intValue
        }
    }

}
