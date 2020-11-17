//
//  QRCustomerConfig.swift
//  Minerva
//
//  Created by Anh Tran on 16/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public class QRCustomerConfig: PaymentMethodConfig {
    public override init(partnerCode: String = "VNPAY") {
        super.init(partnerCode: partnerCode)
    }
}
