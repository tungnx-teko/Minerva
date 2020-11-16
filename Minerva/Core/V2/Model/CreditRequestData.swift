//
//  CreditRequestData.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public class CreditRequestData: PaymentRequestData {
    
    public override init(merchantMethodCode: String, methodCode: String, clientTransactionCode: String, amount: Int) {
        super.init(merchantMethodCode: merchantMethodCode,
                   methodCode: methodCode,
                   clientTransactionCode: clientTransactionCode,
                   amount: amount)
    }
}
