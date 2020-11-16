//
//  PaymentMethodV2.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import TekCoreNetwork

public struct PaymentMethodV2: Decodable {
    public var partnerCode: String
    public var methodCode: String
    public var payType: String
    public var merchantMethodCodes: [MerchantMethodCode]
}

public struct MerchantMethodCode: Decodable {
    var merchantMethodCode: String
    var discountCodes: [String]
}
