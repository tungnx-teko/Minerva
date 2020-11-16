//
//  PaymentRequestData.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public class PaymentRequestData: Encodable {
    var merchantMethodCode: String
    var methodCode: String
    var clientTransactionCode: String
    var amount: Int
    
    init(merchantMethodCode: String, methodCode: String, clientTransactionCode: String, amount: Int) {
        self.merchantMethodCode = merchantMethodCode
        self.methodCode = methodCode
        self.clientTransactionCode = clientTransactionCode
        self.amount = amount
    }
}
