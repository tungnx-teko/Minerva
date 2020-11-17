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
    private let router: QRScanWireframeProtocol
    private let request: PaymentRequest

    var qrReader: QRCodeReader
    
    init(interface: QRScanViewProtocol, router: QRScanWireframeProtocol, request: PaymentRequest) {
        self.view = interface
        self.router = router
        self.request = request
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
//        qrReader.toggleTorch()
        router.showQRInfo(QRInfo.test())
    }
    
    func goBack() {
        router.goBack()
    }
}
