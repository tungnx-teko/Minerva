//
//  QRInfoProtocols.swift
//  Minerva
//
//  Created Anh Tran on 13/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

//MARK: Wireframe
protocol QRInfoWireframeProtocol: class {
    func goBack()
}
//MARK: Presenter
protocol QRInfoPresenterProtocol: class {
    var infoItems: [InfoItem] { get set }
    func goBack()
}

//MARK: View
protocol QRInfoViewProtocol: class {

  var presenter: QRInfoPresenterProtocol?  { get set }
}
