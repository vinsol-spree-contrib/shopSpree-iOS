//
//  CartApiClient.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 08/06/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CartApiClient: BaseApiClient {

    static func addLineItem(_ orderId: String, data: URLRequestParams, success: @escaping (Order) -> Void, failure: @escaping (ApiError) -> Void) {
        Alamofire.request(Router.addItem(order_id: orderId, data: data))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    let order = Order(fromJSON: json)

                    success(order)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }

    static func removeLineItem(_ orderId: String, lineItemID: Int, success: @escaping (Order) -> Void, failure: @escaping (ApiError) -> Void) {
        Alamofire.request(Router.removeItem(order_id: orderId, item_id: lineItemID))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    let order = Order(fromJSON: json)

                    success(order)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
            }
    }

    static func updateLineItem(_ orderId: String, lineItemID: Int, data: URLRequestParams, success: @escaping (Order) -> Void, failure: @escaping (ApiError) -> Void) {
        Alamofire.request(Router.updateItem(order_id: orderId, item_id: lineItemID, data: data))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    let order = Order(fromJSON: json)

                    success(order)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }
}




