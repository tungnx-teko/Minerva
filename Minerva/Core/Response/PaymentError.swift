//
//  PaymentError.swift
//  Core
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public enum PaymentError: Error {
    case timeOut
    case methodNotFound
    case invalidRequest
    case invalidResponse
    case missingPaymentConfig
    case invalidTransactionRequest
    case transaction(error: TransactionError)
}
