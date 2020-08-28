//
//  SposProtocols.swift
//  Pods
//
//  Created by Tung Nguyen on 7/5/20.
//

import Foundation

protocol SposRouterProtocol: class {
    func goToResult(_ result: PaymentResult)
}

protocol SposViewProtocol: class {
    var presenter: SposPresenterProtocol? { get }
    
    func showAmount(_ amount: Double)
    func showTransactionCode(_ code: String)
}

protocol SposPresenterProtocol: class {
    func viewDidLoad()
}
