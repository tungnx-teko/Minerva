//
//  PaymentMethod.swift
//  Core
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation
import TekCoreNetwork

public protocol PaymentMethod {
    var config: PaymentMethodConfig { get }
    var gatewayConfig: PaymentServiceConfig! { get set }
    var methodCode: MethodCode { get }
    
    func validateRequest(request: AnyTransactionRequest) -> PaymentError?
    func constructApiRequest(request: AnyTransactionRequest) throws -> AnyRequest
}

extension PaymentMethod {
    
    func newTransaction(request: AnyTransactionRequest) throws -> AnyTransactionRequest {
        if let error = validateRequest(request: request) { throw error }
        request.withMethodConfig(methodConfig: config, method: methodCode)
        request.withConfig(config: gatewayConfig)
        return request
    }
    
}

public struct AnyTransactionRequest: BaseTransactionRequest {
    
    public typealias TransactionType = BaseTransaction
    
    private let box: AnyTransactionRequestBox
    
    public init<Base>(_ base: Base) where Base: BaseTransactionRequest {
        if let anyRequest = base as? AnyTransactionRequest {
            self = anyRequest
        } else {
            self.box = Box(base: base)
        }
    }
    
    public var base: Any { box.base }
    public var clientCode: String { box.clientCode }
    public var clientTransactionCode: String { box.clientTransactionCode }
    public var terminalCode: String { box.terminalCode }
    public var serviceCode: String { box.serviceCode }
    public var checksum: String { box.checksum }
    
    public func withConfig(config: PaymentServiceConfig) {
        box.withConfig(config: config)
    }
    
    public func withMethodConfig(methodConfig: PaymentMethodConfig, method: MethodCode) {
        box.withMethodConfig(methodConfig: methodConfig, method: method)
    }
}

private protocol AnyTransactionRequestBox {
    var base: Any { get }
    
    var clientCode: String { get }
    var clientTransactionCode: String { get }
    var terminalCode: String { get }
    var serviceCode: String { get }
    var checksum: String { get }
    
    func withConfig(config: PaymentServiceConfig)
    func withMethodConfig(methodConfig: PaymentMethodConfig, method: MethodCode)
}

private struct Box<Base>: AnyTransactionRequestBox where Base: BaseTransactionRequest {
    let _base: Base
    
    init(base: Base) {
        self._base = base
    }
    
    var base: Any { _base }
    var clientCode: String { _base.clientCode }
    var clientTransactionCode: String { _base.clientTransactionCode }
    var terminalCode: String { _base.terminalCode }
    var serviceCode: String { _base.serviceCode }
    var checksum: String { _base.checksum }
    
    func withConfig(config: PaymentServiceConfig) {
        _base.withConfig(config: config)
    }
    func withMethodConfig(methodConfig: PaymentMethodConfig, method: MethodCode) {
        _base.withMethodConfig(methodConfig: methodConfig, method: method)
    }
}
