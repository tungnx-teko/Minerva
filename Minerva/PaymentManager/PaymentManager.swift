//
//  PaymentManager.swift
//  Minerva
//
//  Created by linhvt on 11/11/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

protocol IPaymentManager {
    var methods: [PaymentMethod] { get }
    
    func setPaymentMethods(_ methods: [PaymentMethod])
    func getPaymentMethods() -> [PaymentMethod]
    func addPaymentMethod(_ method: PaymentMethod)
    func clearPaymentMethods()

    func pay<T: BaseTransactionRequest>(method: MethodCode, request: T,
                                        completion: @escaping (Result<T.TransactionType, Error>) -> ()) throws
}

class PaymentManager: IPaymentManager {
    
    var methods: [PaymentMethod] = []
    var config: PaymentServiceConfig
    var paymentService: PaymentService!
    
    init(config: PaymentServiceConfig) {
        self.config = config
        if let url = URL(string: config.baseUrl) {
            self.paymentService = PaymentService(url: url)
        } else {
            print("[MINERVA] Base url not valid")
        }
        
    }
    
    private func getPaymentMethod(from methodCode: MethodCode) -> PaymentMethod? {
        return self.methods.first { $0.methodCode.code == methodCode.code && $0.methodCode.name == methodCode.name }
    }
    
    public func setPaymentMethods(_ methods: [PaymentMethod]) {
        self.methods = methods.map { method in
            var method = method
            method.gatewayConfig = config
            return method
        }
    }
    
    public func getPaymentMethods() -> [PaymentMethod] {
        return methods
    }
    
    public func addPaymentMethod(_ method: PaymentMethod) {
        guard let _ = getPaymentMethod(from: method.methodCode) else {
            self.methods.append(method)
            return
        }
    }
    
    public func clearPaymentMethods() {
        self.methods.removeAll()
    }

    public func pay<T: BaseTransactionRequest>(method: MethodCode, request: T,
                                               completion: @escaping (Result<T.TransactionType, Error>) -> ()) throws {
        guard let paymentService = paymentService else {
            throw PaymentError.missingPaymentConfig
        }
        
        guard let method = getPaymentMethod(from: method) else {
            throw PaymentError.methodNotFound
        }
        
        dump(method)
        dump(request)
        try paymentService.pay(method: method, request: request, completion: { result in
            switch result {
            case .success(let transaction):
                completion(.success(transaction as! T.TransactionType))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    
}


