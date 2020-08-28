//
//  ResultProtocols.swift
//  Pods
//
//  Created by Tung Nguyen on 7/4/20.
//

import Foundation

protocol ResultViewProtocol: class {
    var presenter: ResultPresenterProtocol? { get }
    
    func showResult(_ result: PaymentResult)
}

protocol ResultPresenterProtocol: class {
    var result: PaymentResult { get }
    
    func viewDidLoad()
    func handleClose()
}

protocol ResultRouterProtocol: class {
    
}
