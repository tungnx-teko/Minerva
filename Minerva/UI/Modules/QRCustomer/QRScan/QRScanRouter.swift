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
    
    static func createModule(request: PaymentRequest) -> QRScanViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = QRScanViewController()
        let router = QRScanRouter()
        let presenter = QRScanPresenter(interface: view, router: router, request: request)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func showQRInfo(_ info: QRInfo) {
        let infoVC = QRInfoRouter.createModule(qrInfo: info)
        viewController?.navigationController?.show(infoVC, sender: nil)
    }
}
