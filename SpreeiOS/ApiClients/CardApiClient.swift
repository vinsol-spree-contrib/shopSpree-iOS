//
//  CardApiClient.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 25/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class CardApiClient: BaseApiClient {

    static func cards(_ success: @escaping ([Card]) -> Void, failure: @escaping (ApiError) -> Void ){
        Alamofire.request(Router.cards)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)

                    var cards = [Card]()
                    for cardJSON in json.arrayValue {
                        let card = Card(fromJSON: cardJSON)
                        cards.append(card)
                    }

                    success(cards)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }

    static func addCard(_ data: URLRequestParams, success: () -> Void, failure: @escaping (ApiError) -> Void){
        Alamofire.request(Router.addCard(data: data))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }

    static func removeCard(_ id: Int, success: @escaping (JSON) -> Void, failure: @escaping (ApiError) -> Void){
        Alamofire.request(Router.removeCard(id: id))
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


