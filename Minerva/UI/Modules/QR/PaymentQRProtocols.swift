//
//  PaymentQRProtocols.swift
//  Pods
//
//  Created by Tung Nguyen on 7/2/20.
//

import Foundation
//import MinervaCore

protocol PaymentQRPresenterProtocol: class {
    var transaction: CTTTransaction { get }
    
    func viewDidLoad()
}

protocol PaymentQRViewProtocol: class {
    var presenter: PaymentQRPresenterProtocol? { get }
    
    func showTime(interval: Int)
    func showAmount(amount: Double)
}

protocol PaymentQRRouterProtocol: class {
    func goToResult(_ result: PaymentResult)
}
