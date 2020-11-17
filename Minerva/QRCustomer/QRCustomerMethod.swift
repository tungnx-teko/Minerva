//
//  QRCustomerMethod.swift
//  Minerva
//
//  Created by Anh Tran on 16/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public class QRCustomerMethod: PaymentMethod {
    
    public static let qrCode = MethodCode(name: "VNPay-QR khách hàng", code: "VNPay-QRCustomer")
    
    public var config: PaymentMethodConfig
    public var methodCode: MethodCode
    public var gatewayConfig: PaymentServiceConfig!

    public init(config: QRCustomerConfig, methodCode: MethodCode) {
        self.config = config
        self.methodCode = methodCode
    }
    
    public func validateRequest(request: AnyTransactionRequest) -> PaymentError? {
        return nil
    }
    
    public func constructApiRequest(request: AnyTransactionRequest) throws -> AnyRequest {
        guard let request = request.base as? SPOSTransactionRequest else {
            throw PaymentError.invalidTransactionRequest
        }
        return AnyRequest(SPOSTransactionApiRequest(request: request))
    }
}
