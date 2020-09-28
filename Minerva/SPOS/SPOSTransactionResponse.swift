//
//  SPOSTransactionResponse.swift
//  Spos
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class SPOSTransactionResponse: BaseTransactionResponse {
    public var data: SPOSTransaction?
    public var message: String?
    
    enum CodingKeys: String, CodingKey {
        case data
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(SPOSTransaction.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        try super.init(from: decoder)
    }
}
