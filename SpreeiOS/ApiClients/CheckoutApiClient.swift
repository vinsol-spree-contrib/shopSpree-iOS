//
//  CheckoutApiClient.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 11/08/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class CheckoutApiClient: BaseApiClient {

    static func next(_ id: String, success: @escaping (Order) -> Void, failure: @escaping (ApiError) -> Void) {
        Alamofire.request(Router.nextCheckout(id: id))
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

    static func complete(_ id: String, data: URLRequestParams, success: @escaping (Order) -> Void, failure: @escaping (ApiError) -> Void) {
        Alamofire.request(Router.completeCheckout(id: id, data: data))
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
