//
//  PaymentPresenter.swift
//  Pods
//
//  Created by Tung Nguyen on 7/2/20.
//

import Foundation
//import MinervaCore

public protocol PaymentDelegate: class {
    func onResult(_ result: PaymentResult)
    func onCancel()
}

class PaymentPresenter: PaymentPresenterProtocol {
    
    lazy var gateway = PaymentGateway.shared
    
    weak var view: PaymentViewProtocol?
    var router: PaymentRouterProtocol?
    weak var delegate: PaymentDelegate?
    let request: PaymentRequest
    
    init(view: PaymentViewProtocol, router: PaymentRouterProtocol?, request: PaymentRequest, delegate: PaymentDelegate?) {
        self.view = view
        self.router = router
        self.delegate = delegate
        self.request = request
    }
    
    func onResult(_ result: PaymentResult) {
        delegate?.onResult(result)
        router?.close()
    }
    
    func handleCancel() {
        delegate?.onCancel()
        router?.close()
    }
    
}
