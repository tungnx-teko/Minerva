//
//  PaymentRequest.swift
//  Minerva
//
//  Created by Tung Nguyen on 8/3/20.
//

import Foundation

public class PaymentRequest {
    public var orderId: String
    public var orderCode: String
    public var amount: Double
    public var orderDescription: String
    public var expireTime: Int
    
    /// Init a payment request which will be convert to a BasePaymentRequest
    /// - Parameters:
    ///   - orderId: order id
    ///   - orderCode: order code
    ///   - orderDescription: order description
    ///   - amount: total amount to pay
    ///   - expireTime: waiting time duration (in seconds) before Transaction expired, default is 600 seconds
    public init(orderId: String, orderCode: String, orderDescription: String = "", amount: Double, expireTime: Int = 600) {
        self.orderId = orderId
        self.orderCode = orderCode
        self.orderDescription = orderDescription
        self.amount = amount
        self.expireTime = expireTime
    }
}
