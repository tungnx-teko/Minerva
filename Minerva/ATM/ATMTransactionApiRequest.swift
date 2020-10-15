//
//  CTTTransactionApiRequest.swift
//  CTT
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation
import TekCoreNetwork

class ATMTransactionApiRequest: BaseRequestProtocol {
    
    typealias ResponseType = ATMTransactionResponse
    
    let request: ATMTransactionRequest
    
    init(request: ATMTransactionRequest) {
        self.request = request
    }
    
    var path: String {
        return "/api/transactions/pay"
    }
    
    var encoder: APIParamEncoder {
        return .singleParams(request.dictionary, encoding: JSONParamEncoding.default)
    }
    
    var method: APIMethod {
        return .post
    }
    
    var hasToken: Bool {
        return false
    }
    

}
