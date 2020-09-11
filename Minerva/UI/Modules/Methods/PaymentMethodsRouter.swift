//
//  PaymentMethodsRouter.swift
//  Pods
//
//  Created by Tung Nguyen on 7/2/20.
//

import UIKit

class PaymentMethodsRouter: PaymentMethodsRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(request: PaymentRequest) -> UIViewController {
        let view = PaymentMethodsViewController()
        let router = PaymentMethodsRouter()
        let presenter = PaymentMethodsPresenter(view: view, router: router, request: request)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func goToCTTPayment(transaction: CTTTransaction, request: CTTTransactionRequest) {
        DispatchQueue.main.async { [weak self] in
            let paymentQR = PaymentQRRouter.createModule(transaction: transaction, request: request)
            self?.viewController?.navigationController?.show(paymentQR, sender: nil)
        }
        
    }
    
    func goToSPOSPayment(transaction: SPOSTransaction, request: SPOSTransactionRequest) {
        DispatchQueue.main.async { [weak self] in
            let paymentSpos = SposRouter.createModule(transaction: transaction, request: request)
            self?.viewController?.navigationController?.show(paymentSpos, sender: nil)
        }
    }
    
    func goToFail(error: PaymentError) {
        DispatchQueue.main.async { [weak self] in
            let delegate = self?.viewController?.navigationController?.parent as? PaymentViewController
            let resultModule = ResultRouter.createModule(result: .failure(error), delegate: delegate)
            self?.viewController?.navigationController?.show(resultModule, sender: nil)
        }
    }
    
}
