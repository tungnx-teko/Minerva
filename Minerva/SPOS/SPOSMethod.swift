//
//  SPOSMethod.swift
//  Core
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public class SPOSMethod: PaymentMethod {
    public typealias ApiRequest = SPOSTransactionApiRequest
    public typealias TransactionResponse = SPOSTransactionResponse
    
    public var config: PaymentMethodConfig
    public var methodCode: MethodCode
    
    public init(config: SPOSPaymentConfig, methodCode: MethodCode) {
        self.config = config
        self.methodCode = methodCode
    }
    
    public func validateRequest(request: BaseTransactionRequest) -> PaymentError? {
        return nil
    }
    
    public func constructApiRequest(request: BaseTransactionRequest) throws -> BaseTransactionApiRequest {
        guard let request = request as? SPOSTransactionRequest else {
            throw PaymentError.invalidTransactionRequest
        }
        return SPOSTransactionApiRequest(request: request)
    }
}

