//
//  CTTMethod.swift
//  QR
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class CTTMethod: PaymentMethod {
    
    public static let cttCode = MethodCode(name: "CTT", code: "CTT")
    public static let mmsCode = MethodCode(name: "MMS", code: "QRCODE")
    
    public var config: PaymentMethodConfig
    public var methodCode: MethodCode
    
    public init(config: CTTPaymentConfig, methodCode: MethodCode) {
        self.config = config
        self.methodCode = methodCode
    }
    
    public func validateRequest(request: BaseTransactionRequest) -> PaymentError? {
        return nil
    }
    
    public func constructApiRequest(request: BaseTransactionRequest) throws -> AnyRequest {
        guard let request = request as? CTTTransactionRequest else {
            throw PaymentError.invalidTransactionRequest
        }
        return AnyRequest(CTTTransactionApiRequest(request: request))
    }
    
}
