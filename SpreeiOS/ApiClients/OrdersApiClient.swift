//
//  OrdersApiClient.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 28/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OrderApiClient: BaseApiClient {

    static func current(_ success: @escaping (Order) -> Void, failure: @escaping (ApiError) -> Void ) {
        Alamofire.request(Router.cart)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    let order = Order(fromJSON: json)

                    Order.currentOrder = order

                    success(order)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }

    static func createOrder(_ success: @escaping (Order) -> Void, failure: @escaping (ApiError) -> Void) {
        var data = URLRequestParams()

        data["order[line_items][]"] = nil

        Alamofire.request(Router.createOrder(data: data))
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

    static func orders(_ success: @escaping ([Order]) -> Void, failure: @escaping (ApiError) -> Void ) {
        Alamofire.request(Router.orders)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)

                    var orders = [Order]()
                    for orderJSON in json["orders"].arrayValue {
                        let order = Order(fromJSON: orderJSON)
                        orders.append(order)
                    }

                    success(orders)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }

    static func updateOrder(_ id: String, data: URLRequestParams, success: @escaping (Order) -> Void, failure: @escaping (ApiError) -> Void) {
        Alamofire.request(Router.updateOrder(id: id, data: data))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    success(Order(fromJSON: json))
                case .failure:
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }

}




