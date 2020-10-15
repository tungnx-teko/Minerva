//
//  SPOSTransaction.swift
//  SPOS
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public class SPOSTransaction: BaseTransaction, Decodable {
    public var code: String
    public var merchantPartnerCode: String
    
    enum CodingKeys: String, CodingKey {
        case code = "psTransactionCode"
        case merchantPartnerCode = "merchantPartnerCode"
    }
    
    public init(code: String, merchantPartnerCode: String) {
        self.code = code
        self.merchantPartnerCode = merchantPartnerCode
    }
}


