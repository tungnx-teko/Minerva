//
//  CTTTransaction.swift
//  QR
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class CTTTransaction: Codable {
    public var code: String
    public var qrContent: String
    
    enum CodingKeys: String, CodingKey {
        case code = "psTransactionCode"
        case qrContent = "qrcontent"
    }
    
    public init(code: String, qrContent: String) {
        self.code = code
        self.qrContent = qrContent
    }
}
