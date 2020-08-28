//
//  BaseTransactionRequest.swift
//  Core
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public protocol BaseTransactionRequest {
    var clientCode: String { get set }
    var clientTransactionCode: String { get set }
    var terminalCode: String { get set }
    var serviceCode: String { get set }
    var checksum: String { get set }
    
    func withConfig(config: PaymentServiceConfig)
    func withMethodConfig(methodConfig: PaymentMethodConfig, method: MethodCode)
}
