//
//  Deposit.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public struct Deposit: Decodable {
    // True if order is able to be deposited
    var allowDeposit: Bool
    // Amount of money need to deposit
    var payNowAmount: String?
    // List of deposit policies that the order can apply.
    // Example: 109, 200, 403
    var applyDepositIds: [Int]?
}
