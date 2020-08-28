//
//  PaymentQRPresenter.swift
//  Pods
//
//  Created by Tung Nguyen on 7/2/20.
//

import Foundation
//import MinervaCore

class PaymentQRPresenter: PaymentQRPresenterProtocol, PaymentMethodPresenterProtocol {
    
    weak var view: PaymentQRViewProtocol?
    var router: PaymentQRRouterProtocol?
    let transaction: CTTTransaction
    let request: CTTTransactionRequest
    
    var observer: PaymentObserver = PaymentObserver()
    
    var timer: Timer!
    var timeLeft: Int
    
    init(view: PaymentQRViewProtocol, router: PaymentQRRouterProtocol?, transaction: CTTTransaction, request: CTTTransactionRequest) {
        self.view = view
        self.router = router
        self.transaction = transaction
        self.request = request
        // FIXME:
        self.timeLeft = request.expireTime
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0), target: self, selector: #selector(onTimeFire), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func viewDidLoad() {
        view?.showAmount(amount: Double(request.amount))
        observeTransaction(transactionCode: transaction.code) { [weak self] result in
            self?.router?.goToResult(result)
        }
    }
    
    @objc
    func onTimeFire() {
        timeLeft -= 1
        view?.showTime(interval: timeLeft)
        if timeLeft <= 0 {
            timer.invalidate()
            self.router?.goToResult(.failure(PaymentError.timeOut))
        }
    }
    
    
}
