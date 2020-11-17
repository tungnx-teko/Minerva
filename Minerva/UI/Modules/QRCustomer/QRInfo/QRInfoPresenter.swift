//
//  QRInfoPresenter.swift
//  Minerva
//
//  Created Anh Tran on 13/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit

class QRInfoPresenter: QRInfoPresenterProtocol {

    weak private var view: QRInfoViewProtocol?
    private let router: QRInfoWireframeProtocol
    var infoItems: [InfoItem]

    init(interface: QRInfoViewProtocol, router: QRInfoWireframeProtocol, items: [InfoItem]) {
        self.view = interface
        self.router = router
        self.infoItems = items
    }

    func goBack() {
        router.goBack()
    }
}
