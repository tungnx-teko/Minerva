//
//  SPOSTransactionApiRequest.swift
//  Spos
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation
import TekCoreNetwork

class SPOSTransactionApiRequest: BaseRequestProtocol {
    
    typealias ResponseType = SPOSTransactionResponse
    
    let request: SPOSTransactionRequest
    
    init(request: SPOSTransactionRequest) {
        self.request = request
    }
    
    var path: String {
        return "/transactions/spos"
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
