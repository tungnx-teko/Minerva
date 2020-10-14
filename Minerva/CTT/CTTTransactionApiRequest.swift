//
//  CTTTransactionApiRequest.swift
//  CTT
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation
import TekCoreNetwork

class CTTTransactionApiRequest: BaseRequestProtocol {
    
    typealias ResponseType = CTTTransactionResponse
    
    let request: CTTTransactionRequest
    
    init(request: CTTTransactionRequest) {
        self.request = request
    }
    
    var path: String {
        return "/api/transactions/genqr"
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
