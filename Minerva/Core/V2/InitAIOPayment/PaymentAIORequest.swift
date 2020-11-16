//
//  AIOPaymentRequest.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/9/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import TekCoreNetwork

class PaymentAIORequest: BaseRequestProtocol {
    
    typealias ResponseType = PaymentAIOResponse
    
    enum RequestType {
        case initPaymentAIO(payload: PaymentAIOPayload)
    }
    
    let requestType: RequestType
    
    init(requestType: RequestType) {
        self.requestType = requestType
    }
    
    var path: String {
        return "/api/v2/payment/init/multi"
    }
    
    var encoder: APIParamEncoder {
        switch requestType {
        case .initPaymentAIO(let payload):
            return .singleParams(payload.dictionary, encoding: JSONParamEncoding.default)
        }
    }
    
    var method: APIMethod {
        return .post
    }
    
    var hasToken: Bool {
        return false
    }
    
}

