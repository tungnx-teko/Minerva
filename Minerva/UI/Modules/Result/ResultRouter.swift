//
//  ResultRouter.swift
//  Pods
//
//  Created by Tung Nguyen on 7/4/20.
//

import UIKit
//import MinervaCore

class ResultRouter: ResultRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(result: PaymentResult, delegate: PaymentMethodDelegate?) -> UIViewController {
        let view = ResultViewController()
        let router = ResultRouter()
        let presenter = ResultPresenter(view: view, router: router, result: result, delegate: delegate)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
}
