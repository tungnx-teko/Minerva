//
//  QRScanPresenter.swift
//  Minerva
//
//  Created Anh Tran on 11/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit

class QRScanPresenter: QRScanPresenterProtocol {
    
    weak private var view: QRScanViewProtocol?
    var interactor: QRScanInteractorProtocol?
    private let router: QRScanWireframeProtocol

    var qrReader: QRCodeReader
    
    init(interface: QRScanViewProtocol, interactor: QRScanInteractorProtocol?, router: QRScanWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.qrReader = QRCodeReader(metadataObjectTypes: [AVMetadataObject.ObjectType.qr])
        self.configQRScaner()
    }

    private func configQRScaner() {
        qrReader.setCompletionWith { [weak self] resultStr in
            self?.stopScanQR()
            guard let result = resultStr else { return }
            self?.readResultScan(result)
        }
    }
    
    private func readResultScan(_ result: String) {
        qrReader.readerQRString(result) { [weak self] (bankAccNo, bankName, bankCode, accName, phone, error, message) in
            print("Error: \(message), phone: \(phone), \(bankAccNo)")
        }
    }
    
    func startScanQR() {
        qrReader.startScanning()
    }
    
    func stopScanQR() {
        qrReader.stopScanning()
    }
    
    func toogleTorch() {
        qrReader.toggleTorch()
    }
    
    func goBack() {
        router.goBack()
    }
}
