//
//  File.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 03/09/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import SwiftyJSON

class HomePage {

    enum Section {
        case promoOffers
        case brandOffers
        case categoryOffers
        case newArrivals
    }

    var data = [Section: Banner]()

    func prepareDate(_ json: JSON) {

        for bannerJSON in json.arrayValue {
            let banner = Banner(fromJSON: bannerJSON)

            switch banner.name! {
            case "promo_offer_banner":
                data[.promoOffers] = banner
            case "brand_offer_banner":
                data[.brandOffers] = banner
            case "category_offer_banner":
                data[.categoryOffers] = banner
            case "new_arrival_banner":
                data[.newArrivals] = banner
            default:
                print("Banner: \(banner)")
            }
        }
    }

}

