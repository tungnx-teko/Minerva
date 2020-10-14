//
//  CTTTransaction.swift
//  QR
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class CTTTransaction: Codable {
    public var code: String
    public var qrContent: String?
    public var url: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "psTransactionCode"
        case qrContent = "qrcontent"
        case url = "url"
    }
}
