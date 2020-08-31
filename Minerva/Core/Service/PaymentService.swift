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
    
    func pay(method: PaymentMethod, request: BaseTransactionRequest, completion: @escaping (Result<BaseTransactionResponse, Error>) -> ()) throws {
        let request = try method.newTransaction(request: request)
        let apiRequest = try method.constructApiRequest(request: request)
        switch method {
        case is SPOSMethod:
            guard let request = apiRequest.base as? SPOSTransactionApiRequest else {
                completion(.failure(PaymentError.invalidRequest))
                return
            }
            apiManager.call(request, onSuccess: { response in
                completion(.success(response))
            }) { (error, response) in
                completion(.failure(error))
            }
        case is CTTMethod:
            guard let request = apiRequest.base as? CTTTransactionApiRequest else {
                completion(.failure(PaymentError.invalidRequest))
                return
            }
            apiManager.call(request, onSuccess: { response in
                completion(.success(response))
            }) { (error, response) in
                completion(.failure(error))
            }
        default:
            print("not support method")
        }
    }
    
}
