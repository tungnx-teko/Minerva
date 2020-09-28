//
//  CTTTransactionResponse.swift
//  CTT
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class CTTTransactionResponse: BaseTransactionResponse {
    public var data: CTTTransaction?
    public var message: String?
    
    enum CodingKeys: String, CodingKey {
        case data
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(CTTTransaction.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        try super.init(from: decoder)
    }
}
