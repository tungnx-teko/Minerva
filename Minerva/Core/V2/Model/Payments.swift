//
//  Payments.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public struct PaymentData: Encodable {
    var credit: CreditRequestData?
    var loyalty: LoyaltyRequestData?
    var qr: QrRequestData?
    var card: CardRequestData?
    
    public init(credit: CreditRequestData? = nil, loyalty: LoyaltyRequestData? = nil, qr: QrRequestData? = nil, card: CardRequestData? = nil) {
        self.credit = credit
        self.loyalty = loyalty
        self.qr = qr
        self.card = card
    }
}
