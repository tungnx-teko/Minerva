//
//  PaymentMethodsProtocols.swift
//  Pods
//
//  Created by Tung Nguyen on 7/2/20.
//

import Foundation

protocol PaymentMethodDelegate: class {
    func onResult(_ result: PaymentResult)
}

protocol PaymentMethodsViewProtocol: class {
    var presenter: PaymentMethodsPresenterProtocol? { get }
    func showAmount(_ amount: Double)
    func showLoading()
    func hideLoading()
}

protocol PaymentMethodsPresenterProtocol: class {
    func viewDidLoad()
    func didSelectPaymentMethod(method: PaymentMethod)
}

protocol PaymentMethodsRouterProtocol: class {
    func goToCTTPayment(transaction: CTTTransaction, request: CTTTransactionRequest)
    func goToSPOSPayment(transaction: SPOSTransaction, request: SPOSTransactionRequest)
    func goToFail(error: PaymentError)
}
