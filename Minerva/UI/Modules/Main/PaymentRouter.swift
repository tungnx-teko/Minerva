//
//  PaymentRouter.swift
//  Pods
//
//  Created by Tung Nguyen on 7/2/20.
//

import UIKit

class PaymentRouter: PaymentRouterProtocol {
    
    weak var viewController: PaymentViewController?
    
    static func createModule(request: PaymentRequest, delegate: PaymentDelegate) -> PaymentViewController {
        let view = PaymentViewController()
        let router = PaymentRouter()
        let presenter = PaymentPresenter(view: view, router: router, request: request, delegate: delegate)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func close() {
        if let nav = viewController?.navigationController {
            nav.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
