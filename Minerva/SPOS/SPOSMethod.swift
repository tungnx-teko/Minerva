//
//  SPOSMethod.swift
//  Core
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public class SPOSMethod: PaymentMethod {
    public static let sposCode = MethodCode(name: "SPOS", code: "SPOSCARD")
    
    public var config: PaymentMethodConfig
    public var methodCode: MethodCode
    
    public init(config: SPOSPaymentConfig, methodCode: MethodCode) {
        self.config = config
        self.methodCode = methodCode
    }
    
    public func validateRequest(request: BaseTransactionRequest) -> PaymentError? {
        return nil
    }
    
    public func constructApiRequest(request: BaseTransactionRequest) throws -> AnyRequest {
        guard let request = request as? SPOSTransactionRequest else {
            throw PaymentError.invalidTransactionRequest
        }
        return AnyRequest(SPOSTransactionApiRequest(request: request))
    }
}

