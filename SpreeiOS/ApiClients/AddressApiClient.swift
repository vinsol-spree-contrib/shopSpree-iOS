//
//  AddressApiClient.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 25/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class AddressApiClient: BaseApiClient {

    static func addresses(_ success: @escaping ([Address]) -> Void, failure: @escaping (ApiError) -> Void ) {
        Alamofire.request(Router.addresses)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)

                    var addresses = [Address]()
                    for addressJSON in json.arrayValue {
                        let address = Address(fromJSON: addressJSON)
                        addresses.append(address)
                    }

                    success(addresses)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }

    static func addAddress(_ data: URLRequestParams, success: @escaping (Address) -> Void, failure: @escaping (ApiError) -> Void) {
        Alamofire.request(Router.addAddress(data: data))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    success(Address(fromJSON: json))
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }

    static func updateAddress(_ id: Int, data: URLRequestParams, success: @escaping (Address) -> Void, failure: @escaping (ApiError) -> Void) {
        Alamofire.request(Router.updateAddress(id: id, data: data))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    success(Address(fromJSON: json))
                case .failure:
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }

    static func removeAddress(_ id: Int, success: @escaping (JSON) -> Void, failure: @escaping (ApiError) -> Void) {
        Alamofire.request(Router.removeAddress(id: id))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    success(json)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }
    
}



