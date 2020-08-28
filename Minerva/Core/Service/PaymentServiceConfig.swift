//
//  PaymentServiceConfig.swift
//  Core
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public class PaymentServiceConfig {
    public var clientCode: String
    public var terminalCode: String
    public var serviceCode: String
    public var secretKey: String
    public var baseUrl: String
    
    public init(clientCode: String, terminalCode: String, serviceCode: String, secretKey: String, baseUrl: String) {
        self.clientCode = clientCode
        self.terminalCode = terminalCode
        self.serviceCode = serviceCode
        self.secretKey = secretKey
        self.baseUrl = baseUrl
    }
    
}
