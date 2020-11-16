//
//  BasePaymentData.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/9/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public struct PaymentAIOPayload: Encodable {
    var orderCode: String
    var userId: String
    var terminalCode: String
    var totalPaymentAmount: Int
    var payments: PaymentData
    var successUrl: String
    var cancelUrl: String
    var checksum: String?
    
    public init(orderCode: String, userId: String, totalPaymentAmount: Int, payments: PaymentData, successUrl: String, cancelUrl: String) {
        self.orderCode = orderCode
        self.userId = userId
        self.terminalCode = Minerva.shared.config.terminalCode
        self.totalPaymentAmount = totalPaymentAmount
        self.payments = payments
        self.successUrl = successUrl
        self.cancelUrl = cancelUrl
        checksum = generateChecksum()
    }
    
    private func generateChecksum() -> String {
        var string: String = "\(Minerva.shared.config.secretKey)\(orderCode)|\(userId)|\(terminalCode)|\(totalPaymentAmount)|\(successUrl)|\(cancelUrl)"
        ///order by Loyalty > QR > Card > Credit
        if let loyalty = payments.loyalty {
            string += "|\(loyalty.clientTransactionCode)|\(loyalty.merchantMethodCode)|\(loyalty.methodCode)|\(loyalty.amount)"
        }
        if let qr = payments.qr {
            string += "|\(qr.clientTransactionCode)|\(qr.merchantMethodCode)|\(qr.methodCode)|\(qr.amount)"
        }
        if let card = payments.card {
            string += "|\(card.clientTransactionCode)|\(card.merchantMethodCode)|\(card.methodCode)|\(card.amount)"
        }
        if let credit = payments.credit {
            string += "|\(credit.clientTransactionCode)|\(credit.merchantMethodCode)|\(credit.methodCode)|\(credit.amount)"
        }
        return CrypUtils.sha256(text: string)
    }
}
