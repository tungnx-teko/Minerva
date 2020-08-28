//
//  SposRouter.swift
//  Pods
//
//  Created by Tung Nguyen on 7/6/20.
//

import UIKit
//import MinervaCore

class SposRouter: SposRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(transaction: SPOSTransaction, request: SPOSTransactionRequest) -> UIViewController {
        let view = SposViewController()
        let router = SposRouter()
        let presenter = SposPresenter(view: view, router: router, transaction: transaction, request: request)
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func goToResult(_ result: PaymentResult) {
        let delegate = viewController?.navigationController?.parent as? PaymentViewController
        let resultModule = ResultRouter.createModule(result: result, delegate: delegate)
        viewController?.navigationController?.show(resultModule, sender: nil)
    }
    
    func dismiss() {
        viewController?.parent?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
