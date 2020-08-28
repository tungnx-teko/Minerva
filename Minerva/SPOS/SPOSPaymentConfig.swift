//
//  SPOSPaymentConfig.swift
//  Spos
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public class SPOSPaymentConfig: PaymentMethodConfig {
    let mcc: String
    
    public init(mcc: String = "", partnerCode: String = "VNPAY") {
        self.mcc = mcc
        super.init(partnerCode: partnerCode)
    }
}
