//
//  PaymentGateway.swift
//  Core
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class PaymentGateway {
    
    public static let shared = PaymentGateway()
    
    private init() {}
    
    static var config: PaymentServiceConfig!
    
    static var environment: Environment = .development
    
    public static var methods: [PaymentMethod] = []
    
    lazy var paymentService = PaymentService(url: URL(string: PaymentGateway.config.baseUrl)!)
    
    public static func initialize(withConfig config: PaymentServiceConfig, environment: Environment) {
        PaymentGateway.config = config
        PaymentGateway.environment = environment
    }
    
    public static func setPaymentMethods(methods: [PaymentMethod]) {
        PaymentGateway.methods = methods
    }
    
    public func pay(method: PaymentMethod, request: BaseTransactionRequest, completion: @escaping (Result<BaseTransactionResponse, Error>) -> ()) throws {
        guard let _ = PaymentGateway.config else {
            throw PaymentError.missingPaymentConfig
        }
        guard let method = getPaymentMethod(fromCode: method.methodCode.code) else {
            throw PaymentError.methodNotFound
        }
        try paymentService.pay(method: method, request: request, completion: { result in
            completion(result)
        })
    }
    
    private func getPaymentMethod(fromCode code: String) -> PaymentMethod? {
        return PaymentGateway.methods.first { $0.methodCode.code == code }
    }
    
}
