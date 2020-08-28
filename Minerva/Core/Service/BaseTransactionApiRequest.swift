//
//  BaseTransactionApiRequest.swift
//  Core
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation
import TekCoreNetwork

public typealias TransactionRequestType = BaseTransactionRequest & Encodable

open class BaseTransactionApiRequest: BaseRequestProtocol {
    
    public typealias ResponseType = BaseTransactionResponse
    
    var request: TransactionRequestType
    
    open var encoder: APIParamEncoder {
        return .singleParams(request.dictionary, encoding: JSONParamEncoding.default)
    }
    
    open var method: APIMethod {
        return .post
    }
    
    open var path: String {
        return ""
    }
    
    open var hasToken: Bool {
        return false
    }
    
    public init(request: TransactionRequestType) {
        self.request = request
    }
    
}
