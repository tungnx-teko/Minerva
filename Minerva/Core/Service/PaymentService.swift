//
//  PaymentService.swift
//  Core
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation
import TekCoreService
import TekCoreNetwork

class PaymentService: BaseService<APIManager> {
    
    func pay<T: BaseTransactionRequest>(method: PaymentMethod, request: T, completion: @escaping (Result<BaseTransaction, Error>) -> ()) throws {
        let erasuredRequest = AnyTransactionRequest(request)
        let request = try method.newTransaction(request: erasuredRequest)
        let apiRequest = try method.constructApiRequest(request: request)
        switch method {
        case is SPOSMethod:
            guard let request = apiRequest.base as? SPOSTransactionApiRequest else {
                completion(.failure(PaymentError.invalidRequest))
                return
            }
            
            apiManager.call(request, onSuccess: { response in
                guard let transaction = response.data else {
                    return
                }
                completion(.success(transaction))
            }) { (error, response) in
                completion(.failure(error))
            }
        case is CTTMethod:
            guard let request = apiRequest.base as? CTTTransactionApiRequest else {
                completion(.failure(PaymentError.invalidRequest))
                return
            }
            apiManager.call(request, onSuccess: { response in
                guard let transaction = response.data else {
                    return
                }
                completion(.success(transaction))
            }) { (error, response) in
                completion(.failure(error))
            }
        default:
            print("not support method")
        }
    }
    
}
