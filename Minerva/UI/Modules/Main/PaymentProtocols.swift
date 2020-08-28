//
//  PaymentProtocols.swift
//  Alamofire
//
//  Created by Tung Nguyen on 7/2/20.
//

import Foundation
//import MinervaCore

protocol PaymentPresenterProtocol: class {
    var request: PaymentRequest { get }
    
    func onResult(_ result: PaymentResult)
    func handleCancel()
}

protocol PaymentViewProtocol: class {
    var presenter: PaymentPresenterProtocol? { get }
}

protocol PaymentRouterProtocol: class {
    func close()
}
