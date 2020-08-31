//
//  PaymentMethod.swift
//  Core
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation
import TekCoreNetwork

public protocol PaymentMethod {
    var config: PaymentMethodConfig { get }
    var methodCode: MethodCode { get }
    
    func validateRequest(request: BaseTransactionRequest) -> PaymentError?
    func constructApiRequest(request: BaseTransactionRequest) throws -> AnyRequest
}

extension PaymentMethod {
    
    func newTransaction(request: BaseTransactionRequest) throws -> BaseTransactionRequest {
        guard let gatewayConfig = PaymentGateway.config else {
            throw PaymentError.missingPaymentConfig
        }
        if let error = validateRequest(request: request) { throw error }
        request.withConfig(config: gatewayConfig)
        request.withMethodConfig(methodConfig: config, method: methodCode)
        return request
    }
    
}
