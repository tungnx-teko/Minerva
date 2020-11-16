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
    
    
    
    func getPaymentMethods(payload: PaymentMethodsGetPayload,
                           completion: @escaping (Result<PaymentMethodsGetResponse, PaymentError>) -> ()) {
        let request = PaymentMethodsGetRequest(payload: payload)
        apiManager.call(request, onSuccess: { response in
            completion(.success(response))
        }) { (error, response) in
            completion(.failure(.custom(message: error.localizedDescription)))
        }
    }
    
    func initAIOPayment(payload: PaymentAIOPayload, completion: @escaping (Result<PaymentAIOResponse, PaymentError>) -> ()) {
        let request = PaymentAIORequest(requestType: .initPaymentAIO(payload: payload))
        apiManager.call(request, onSuccess: { response in
            completion(.success(response))
        }) { (error, response) in
            print(error)
            completion(.failure(.custom(message: response?.code.message ?? error.localizedDescription)))
        }
    }
    
    func pay<T: BaseTransactionRequest>(method: PaymentMethod, request: T, completion: @escaping (Result<BaseTransaction, Error>) -> ()) throws {
        let erasuredRequest = AnyTransactionRequest(request)
        let request = try method.newTransaction(request: erasuredRequest)
        let apiRequest = try method.constructApiRequest(request: request)
        dump(apiRequest)
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
        case is ATMMethod:
            guard let request = apiRequest.base as? ATMTransactionApiRequest else {
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
