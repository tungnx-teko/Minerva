//
//  BaseTransactionRequest.swift
//  Core
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public protocol BaseTransactionRequest {
    associatedtype TransactionType
    var clientCode: String { get }
    var clientTransactionCode: String { get }
    var terminalCode: String { get }
    var serviceCode: String { get }
    var checksum: String { get }
    
    func withConfig(config: PaymentServiceConfig)
    func withMethodConfig(methodConfig: PaymentMethodConfig, method: MethodCode)
}
