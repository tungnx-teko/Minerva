//
//  CardRequestData.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public class CardRequestData: PaymentRequestData {
    
    public enum PaymentCardType: Int {
        case redirect = 1
        case qrcode = 2
    }
    
    private(set) public var bankCode: String
    private(set) public var type: Int
    private(set) public var token: String
    
    enum CodingKeys: String, CodingKey {
        case merchantMethodCode, methodCode, clientTransactionCode, amount, bankCode, type, token
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(merchantMethodCode, forKey: .merchantMethodCode)
        try container.encode(methodCode, forKey: .methodCode)
        try container.encode(clientTransactionCode, forKey: .clientTransactionCode)
        try container.encode(amount, forKey: .amount)
        try container.encode(bankCode, forKey: .bankCode)
        try container.encode(type, forKey: .type)
        try container.encode(token, forKey: .token)
    }
    
    public init(merchantMethodCode: String, methodCode: String, clientTransactionCode: String, amount: Int, bankCode: String, type: PaymentCardType, token: String) {
        self.bankCode = bankCode
        self.type = type.rawValue
        self.token = token
        super.init(merchantMethodCode: merchantMethodCode,
                   methodCode: methodCode,
                   clientTransactionCode: clientTransactionCode,
                   amount: amount)
    }
}
