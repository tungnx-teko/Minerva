//
//  PaymentCodeV2.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import TekCoreNetwork

public class PaymentCodeV2: TekoCodeProtocol, Decodable {
    
    public var successCode: String = "200"
    
    public var code: String?
    public let error: Error?
    public let message: String?
    public let details: [PaymentV2Error]?
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case details = "details"
        case code
        case message = "message"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        if let code = try? container.decodeIfPresent(String.self, forKey: .code) {
            self.code = code
        } else if let code = try? container.decodeIfPresent(Int.self, forKey: .code) {
            self.code = "\(code)"
        } else {
            self.code = self.successCode
        }
        self.details = try container.decodeIfPresent([PaymentV2Error].self, forKey: .details)
        self.error = PaymentError.custom(message: self.message ?? "unexpected_error")
    }
    
}

public class PaymentV2Error: Decodable {
    var type: String?
    var metadatas: [PaymentV2ErrorMetaData]?
}

public class PaymentV2ErrorMetaData: Decodable {
    var key: String?
    var value: String?
}
