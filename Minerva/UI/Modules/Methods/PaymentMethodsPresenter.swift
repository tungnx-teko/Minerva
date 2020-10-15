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
            
            requestPayment(method: method, request: AnyTransactionRequest(sposRequest))
        case is CTTMethod:
            let cttRequest = CTTTransactionRequest(orderId: request.orderId,
                                                   orderCode: request.orderCode,
                                                   amount: request.amount.intValue)
            requestPayment(method: method, request: AnyTransactionRequest(cttRequest))
        case is ATMMethod:
            let atmRequest = ATMTransactionRequest(orderId: request.orderId,
                                                   orderCode: request.orderCode,
                                                   amount: request.amount.intValue,
                                                   returnUrl: "https://vnshop.vn/payment/return",
                                                   cancelUrl: "https://vnshop.vn/payment/cancel")
            requestPayment(method: method, request: AnyTransactionRequest(atmRequest))
        default:
            break
        }
    }
    
    private func requestPayment(method: PaymentMethod, request: AnyTransactionRequest) {
        view?.showLoading()
        do {
            try Minerva.shared.pay(method: method.methodCode, request: request, completion: { [weak self] result in
                self?.view?.hideLoading()
                switch result {
                case .success(let transaction):
                    self?.showTransactionInformation(transaction: transaction, request: request)
                case .failure(let error):
                    print(error)
                }
            })
        } catch {
            print(error)
        }
    }
    
    func showTransactionInformation(transaction: BaseTransaction, request: AnyTransactionRequest) {
        switch transaction {
        case let transaction as SPOSTransaction:
            router?.goToSPOSPayment(transaction: transaction, request: request.base as! SPOSTransactionRequest)
        case let transaction as CTTTransaction:
            router?.goToCTTPayment(transaction: transaction, request: request.base as! CTTTransactionRequest)
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
