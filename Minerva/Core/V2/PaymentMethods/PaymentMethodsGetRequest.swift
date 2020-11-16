//
//  PaymentMethodsGetRequest.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

import TekCoreNetwork

class PaymentMethodsGetRequest: BaseRequestProtocol {
    
    typealias ResponseType = PaymentMethodsGetResponse
    
    var path: String {
        return "/api/v2/settings/get-payment-methods"
    }
    
    let payload: PaymentMethodsGetPayload
    
    init(payload: PaymentMethodsGetPayload) {
        self.payload = payload
    }
    
    var encoder: APIParamEncoder {
        return .singleParams(payload.dictionary, encoding: JSONParamEncoding.default)
    }
    
    var method: APIMethod {
        return .post
    }
    
    var hasToken: Bool {
        return false
    }
    
}


