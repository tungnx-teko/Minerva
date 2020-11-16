//
//  PaymentMethodsGetPayload.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public struct PaymentMethodsGetPayload: Encodable {
    // User id
    var userId: String?
    
    // Seller terminal code
    var terminalCode: String
    
    // Order total amount (after applying promotions, discount)
    var amount: Int
    
    // Product list
    var orderItems: [OrderItem]
    
    public init(userId: String? = nil, terminalCode: String, amount: Int, orderItems: [OrderItem]) {
        self.userId = userId
        self.terminalCode = terminalCode
        self.amount = amount
        self.orderItems = orderItems
    }
}
