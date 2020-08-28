//
//  SposPresenter.swift
//  Pods
//
//  Created by Tung Nguyen on 7/5/20.
//

//import MinervaCore

class SposPresenter: SposPresenterProtocol, PaymentMethodPresenterProtocol {
    
    weak var view: SposViewProtocol?
    var router: SposRouterProtocol?
    let transaction: SPOSTransaction
    let request: SPOSTransactionRequest
    
    lazy var observer: PaymentObserver = .init()
    
    init(view: SposViewProtocol, router: SposRouterProtocol?, transaction: SPOSTransaction, request: SPOSTransactionRequest) {
        self.view = view
        self.router = router
        self.transaction = transaction
        self.request = request
    }
    
    func viewDidLoad() {
        view?.showAmount(Double(request.amount))
        view?.showTransactionCode(transaction.code)
        observeTransaction(transactionCode: transaction.code) { [weak self] result in
            self?.router?.goToResult(result)
        }
    }
    
}
