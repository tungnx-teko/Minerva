//
//  PaymentMethodConfig.swift
//  Core
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

open class PaymentMethodConfig {
    public var partnerCode: String
    
    public init(partnerCode: String) {
        self.partnerCode = partnerCode
    }
}
