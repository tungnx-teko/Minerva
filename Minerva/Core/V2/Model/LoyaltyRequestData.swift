//
//  LoyaltyRequestData.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public class LoyaltyRequestData: PaymentRequestData {
    
    private(set) public var points: Int
    
    public init(merchantMethodCode: String, methodCode: String, clientTransactionCode: String, amount: Int, points: Int) {
        self.points = points
        super.init(merchantMethodCode: merchantMethodCode,
                   methodCode: methodCode,
                   clientTransactionCode: clientTransactionCode,
                   amount: amount)
    }
}
