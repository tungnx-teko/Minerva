//
//  CTTMethod.swift
//  QR
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class ATMMethod: PaymentMethod {
    
    public static let atmCode = MethodCode(name: "ATM", code: "CTT")
    
    public var config: PaymentMethodConfig
    public var methodCode: MethodCode
    
    public init(config: ATMPaymentConfig, methodCode: MethodCode) {
        self.config = config
        self.methodCode = methodCode
    }
    
    public func validateRequest(request: AnyTransactionRequest) -> PaymentError? {
        return nil
    }
    
    public func constructApiRequest(request: AnyTransactionRequest) throws -> AnyRequest {
        guard let request = request.base as? ATMTransactionRequest else {
            throw PaymentError.invalidTransactionRequest
        }
        return AnyRequest(ATMTransactionApiRequest(request: request))
    }
    
}
