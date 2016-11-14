//
//  BaseApiClient.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 11/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit
import Alamofire

typealias URLRequestParams = [String: Any]

class BaseApiClient {

}

extension BaseApiClient {
    enum Router: URLRequestConvertible {

        static let domainName  = "http://shop-spree.herokuapp.com"

        static let apiPathName = "api/ams"

        static let baseURLString = "\(domainName)/\(apiPathName)"

        // MARK: - Routes
        case home
        case login(data: URLRequestParams)
        case signup(data: URLRequestParams)
        case forgotPassword(data: URLRequestParams)

        case cards
        case addCard(data: URLRequestParams)
        case removeCard(id: Int)

        case addresses
        case addAddress(data: URLRequestParams)
        case updateAddress(id: Int, data: URLRequestParams)
        case removeAddress(id: Int)

        case products(data: URLRequestParams)
        case product(id: Int)

        case orders
        case createOrder(data: URLRequestParams)
        case updateOrder(id: String, data: URLRequestParams)

        case cart
        case addItem(order_id: String, data: URLRequestParams)
        case updateItem(order_id: String, item_id: Int, data: URLRequestParams)
        case removeItem(order_id: String, item_id: Int)

        case nextCheckout(id: String)
        case completeCheckout(id: String, data: URLRequestParams)

        // MARK: - Methods
        var method: HTTPMethod {
            switch self {
            case .login, .signup, .forgotPassword, .addCard, .addAddress, .addItem, .createOrder:
                return .post
            case .removeCard, .removeAddress, .removeItem:
                return .delete
            case .updateAddress, .updateItem:
                return .patch
            case .updateOrder, .nextCheckout, .completeCheckout:
                return .put
            default:
                return .get
            }
        }


        // MARK: - Paths
        var path: String {
            switch self {
            case .home:                                                     return "/home"
            case .login(_):                                                 return "/users/sign_in"
            case .signup(_):                                                return "/users"
            case .forgotPassword(_):                                        return "/password/reset"
            case .cards:                                                    return "/users/credit_cards"
            case .addCard(_):                                               return "/users/credit_cards"
            case .removeCard(let id):                                       return "/users/credit_cards/\(id)"
            case .addresses:                                                return "/user/addresses"
            case .addAddress(_):                                            return "/user/addresses"
            case .updateAddress(let id, _):                                 return "/user/addresses/\(id)"
            case .removeAddress(let id):                                    return "/user/addresses/\(id)"
            case .products(_):                                              return "/products"
            case .product(let id):                                          return "/products/\(id)"
            case .orders:                                                   return "/orders/mine"
            case .createOrder(_):                                           return "/orders/"
            case .updateOrder(let id, _):                                   return "/orders/\(id)"
            case .cart:                                                     return "/orders/current"
            case .addItem(let order_id, _):                                 return "/orders/\(order_id)/line_items"
            case .updateItem(let order_id, let item_id, _):                 return "/orders/\(order_id)/line_items/\(item_id)"
            case .removeItem(let order_id, let item_id):                    return "/orders/\(order_id)/line_items/\(item_id)"
            case .nextCheckout(let order_id):                               return "/checkouts/\(order_id)/next"
            case .completeCheckout(let order_id, _):                        return "/checkouts/\(order_id)"
            }
        }



        // MARK: - Parameters
        var parameters: URLRequestParams? {
            var params: URLRequestParams?

            switch self {
            case .login(let data):                      params = data
            case .signup(let data):                     params = data
            case .forgotPassword(let data):             params = data
            case .products(let data):                   params = data
            case .addCard(let data):                    params = data
            case .addAddress(let data):                 params = data
            case .addItem(_, let data):                 params = data
            case .updateAddress(_, let data):           params = data
            case .updateItem(_, _, let data):           params = data
            case .createOrder(let data):                params = data
            case .updateOrder(_, let data):             params = data
            case .completeCheckout(_, let data):        params = data
            default:                                    params = nil
            }

            if User.isLoggedIn {
                let token = User.currentUser!.spreeApiKey!

                if params == nil {
                    params = ["token" : token]
                } else {
                    params!["token"] = token
                }
            }

            return params
        }


        func asURLRequest() throws -> URLRequest {
            let url = try Router.baseURLString.asURL()

            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue

            if let parameters = parameters {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            }

            print("*** \(urlRequest)")

            return urlRequest
        }

    }
}
