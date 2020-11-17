//
//  QRInfoRouter.swift
//  Minerva
//
//  Created Anh Tran on 13/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit

class QRInfoRouter: QRInfoWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(qrInfo: QRInfo) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = QRInfoViewController()
        let router = QRInfoRouter()
        let presenter = QRInfoPresenter(interface: view, router: router, items: qrInfo.toInfoItems())
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
