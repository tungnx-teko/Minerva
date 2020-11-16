//
//  PaymentMethodsGetResponse.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import TekCoreNetwork

public class PaymentMethodsGetResponse: BaseResponse<PaymentCodeV2> {
    public var merchantCode: String
    public var paymentMethods: [PaymentMethodV2]
    public var deposit: Deposit?
    
    enum CodingKeys: String, CodingKey {
        case merchantCode, paymentMethods, deposit
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        merchantCode = try values.decodeIfPresent(String.self, forKey: .merchantCode) ?? ""
        paymentMethods = try values.decodeIfPresent([PaymentMethodV2].self, forKey: .paymentMethods) ?? []
        deposit = try values.decodeIfPresent(Deposit.self, forKey: .deposit)
        try super.init(from: decoder)
    }
}
    
