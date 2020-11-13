//
//  QRScanRouter.swift
//  Minerva
//
//  Created Anh Tran on 11/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
 
class QRScanRouter: QRScanWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> QRScanViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = QRScanViewController()
        let interactor = QRScanInteractor()
        let router = QRScanRouter()
        let presenter = QRScanPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func goBack() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
