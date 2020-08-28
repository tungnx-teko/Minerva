//
//  PaymentService.swift
//  Core
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation
import TekCoreService

public class PaymentService: BaseService<APIManager> {
    
    public func pay(method: PaymentMethod, request: BaseTransactionRequest, completion: @escaping (Result<BaseTransactionResponse, Error>) -> ()) throws {
        let request = try method.newTransaction(request: request)
        let apiRequest = try method.constructApiRequest(request: request)
        apiManager.call(apiRequest, onSuccess: { response in
            completion(.success(response))
        }) { (error, response) in
            completion(.failure(error))
        }
    }
    
}
