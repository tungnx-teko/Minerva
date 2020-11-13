//
//  QRScanProtocols.swift
//  Minerva
//
//  Created Anh Tran on 11/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

//MARK: Wireframe
protocol QRScanWireframeProtocol: class {
    func goBack()
}
//MARK: Presenter
protocol QRScanPresenterProtocol: class {
    var qrReader: QRCodeReader { get }
    
    func startScanQR()
    func stopScanQR()
    func toogleTorch()
    func goBack()
}

//MARK: Interactor
protocol QRScanInteractorProtocol: class {

  var presenter: QRScanPresenterProtocol?  { get set }
}

//MARK: View
protocol QRScanViewProtocol: class {

  var presenter: QRScanPresenterProtocol?  { get set }
}
