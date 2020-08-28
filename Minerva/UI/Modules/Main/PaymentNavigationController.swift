//
//  PaymentNavigationController.swift
//  Pods
//
//  Created by Tung Nguyen on 7/2/20.
//

import UIKit

protocol PaymentNavigationDelegate: class {
    func didShowViewController(_ vc: UIViewController)
    func didPop()
}

class PaymentNavigationController: UINavigationController {
    
    weak var navDelegate: PaymentNavigationDelegate?
    
    override func show(_ vc: UIViewController, sender: Any?) {
        super.show(vc, sender: sender)
        navDelegate?.didShowViewController(vc)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let viewController = super.popViewController(animated: animated)
        navDelegate?.didPop()
        return viewController
    }
    
    var canGoBack: Bool {
        return viewControllers.count > 1
    }
    
}
