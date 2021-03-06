//
//  CTTTransactionRequest.swift
//  CTT
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class CTTTransactionRequest: BaseTransactionRequest, Encodable {
    public var clientCode: String = ""
    public var clientTransactionCode: String = ""
    public var terminalCode: String = ""
    public var serviceCode: String = ""
    public var checksum: String = ""
    
    var bankCode: String
    var orderId: String
    var orderCode: String
    var orderDescription: String?
    var amount: Int
    var returnUrl: String?
    var cancelUrl: String?
    var clientRequestTime: String
    var methodCode: String = ""
    var partnerCode: String
    var expireTime: Int
    
    public init(bankCode: String = "", orderId: String, orderCode: String, orderDescription: String? = nil, amount: Int, partnerCode: String = "VNPAY", returnUrl: String? = nil, cancelUrl: String? = nil, expireTime: Int = 600) {
        self.bankCode = bankCode
        self.orderId = orderId
        self.orderCode = orderCode
        self.orderDescription = orderDescription
        self.amount = amount
        self.clientRequestTime = DateUtils.toString(date: Date())
//        self.methodCode = methodCode
        self.partnerCode = partnerCode
        self.returnUrl = returnUrl
        self.cancelUrl = cancelUrl
        self.expireTime = expireTime
    }
    
    public func withConfig(config: PaymentServiceConfig) {
        clientCode = config.clientCode
        clientTransactionCode = UUID().uuidString
        terminalCode = config.terminalCode
        serviceCode = config.serviceCode
        checksum = MD5Encryptor.md5(text: self.stringify(), secretKey: config.secretKey)
    }
    
    public func withMethodConfig(methodConfig: PaymentMethodConfig, method: MethodCode) {
        partnerCode = methodConfig.partnerCode
        methodCode = method.code
    }
}
