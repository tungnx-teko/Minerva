//
//  QrRequestData.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public class QrRequestData: PaymentRequestData {
    private(set) public var qrWidth: Int?
    private(set) public var qrHeight: Int?
    private(set) public var qrImageType: Int?
    
    public enum QRImageType: Int {
        case binary = 1
        case image = 2
    }
    
    public init(merchantMethodCode: String, methodCode: String, clientTransactionCode: String, amount: Int, qrWidth: Int? = nil, qrHeight: Int? = nil, qrImageType: QRImageType = .binary) {
        self.qrWidth = qrWidth
        self.qrHeight = qrHeight
        self.qrImageType = qrImageType.rawValue
        super.init(merchantMethodCode: merchantMethodCode,
                   methodCode: methodCode,
                   clientTransactionCode: clientTransactionCode,
                   amount: amount)
    }
}
