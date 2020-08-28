//
//  CTTPaymentConfig.swift
//  CTT
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class CTTPaymentConfig: PaymentMethodConfig {
    
    public override init(partnerCode: String = "VNPAY") {
        super.init(partnerCode: partnerCode)
    }
}
