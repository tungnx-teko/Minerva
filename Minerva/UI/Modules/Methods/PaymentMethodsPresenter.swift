//
//  PaymentMethodsPresenter.swift
//  Pods
//
//  Created by Tung Nguyen on 7/2/20.
//

import Foundation
//import MinervaCore

class PaymentMethodsPresenter: PaymentMethodsPresenterProtocol {
    
    weak var view: PaymentMethodsViewProtocol?
    var router: PaymentMethodsRouterProtocol?
    let request: PaymentRequest
    
    init(view: PaymentMethodsViewProtocol, router: PaymentMethodsRouterProtocol?, request: PaymentRequest) {
        self.view = view
        self.router = router
        self.request = request
    }
    
    func didSelectPaymentMethod(method: PaymentMethod) {
        view?.showLoading()
        switch method {
        case is SPOSMethod:
            let sposRequest = SPOSTransactionRequest(orderId: request.orderId,
                                                     orderCode: request.orderCode,
                                                     amount: request.amount.intValue)
            
            requestPayment(method: method, request: sposRequest)
        case is CTTMethod:
            let cttRequest = CTTTransactionRequest(orderId: request.orderId,
                                                   orderCode: request.orderCode,
                                                   amount: request.amount.intValue)
            requestPayment(method: method, request: cttRequest)
        default:
            break
        }
    }
    
    private func requestPayment(method: PaymentMethod, request: BaseTransactionRequest) {
        view?.showLoading()
        do {
            try Minerva.shared.pay(method: method.methodCode, request: request, completion: { [weak self] result in
                self?.view?.hideLoading()
                switch result {
                case .success(let response):
                    self?.showTransactionInformation(response: response, request: request)
                case .failure(let error):
                    print(error)
                }
            })
        } catch {
            print(error)
        }
    }
    
    func showTransactionInformation(response: BaseTransactionResponse, request: BaseTransactionRequest) {
        switch response {
        case let response as SPOSTransactionResponse:
            guard let transaction = response.data, let request = request as? SPOSTransactionRequest else {
                fatalError("Mismatch response type")
            }
            router?.goToSPOSPayment(transaction: transaction, request: request)
        case let response as CTTTransactionResponse:
            guard let transaction = response.data, let request = request as? CTTTransactionRequest else {
                fatalError("Mismatch response type")
            }
            router?.goToCTTPayment(transaction: transaction, request: request)
        default: ()
        }
    }
    
    func showFailInformation(error: Error) {
        guard let error = error as? PaymentError else { return }
        self.router?.goToFail(error: error)
    }
    
//    private func didSelectQRMethod() {
//        guard let methodCode = PaymentGateway.getPaymentMethod("")
//        let qrRequest = CTTTransactionRequest(orderId: request.orderId,
//                                              orderCode: request.orderCode,
//                                              amount: request.amount.intValue,
//                                              methodCode: "CTT")
//        let qrRequest = QRPaymentRequest(orderId: request.orderId, orderCode: request.orderCode, amount: request.amount,
//                                         orderDescription: request.orderDescription)
//        do {
//            try gateway.pay(method: .qr, request: qrRequest, completion: { [weak self] result in
//                guard let self = self else { return }
//                self.view?.hideLoading()
//                switch result {
//                case .success(let transaction):
//                    self.router?.goToSposPayment(transaction: transaction, request: self.request, title: Minerva.Strings.paymentQRTitle)
//                case .failure(let error):
//                    self.router?.goToFail(result: .failure(error))
//                }
//            })
//        } catch {
//            if let error = error as? MinervaError {
//                self.router?.goToFail(result: .failure(error))
//            }
//        }
//    }
//
//    private func didSelectSPOSMethod() {
//        let sposRequest = SPOSPaymentRequest(orderId: request.orderId, orderCode: request.orderCode,
//                                             orderDescription: request.orderDescription,
//                                             amount: request.amount)
//        do {
//            try gateway.pay(method: .spos, request: sposRequest, completion: { [weak self] result in
//                guard let self = self else { return }
//                self.view?.hideLoading()
//                switch result {
//                case .success(let transaction):
//                    self.router?.goToSposPayment(transaction: transaction, request: self.request, title: Minerva.Strings.paymentSPOSMethod)
//                case .failure(let error):
//                    self.router?.goToFail(result: .failure(error))
//                }
//            })
//        } catch {
//            if let error = error as? MinervaError {
//                self.router?.goToFail(result: .failure(error))
//            }
//        }
//    }
    
    func viewDidLoad() {
        view?.showAmount(request.amount)
    }
    
}
