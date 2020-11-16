//
//  ViewController.swift
//  Example
//
//  Created by Tung Nguyen on 8/27/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import Minerva

class ViewController: UIViewController, PaymentDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hi")
    }
    
    @IBAction func paymentMethodsWasTapped(_ sender: Any) {
        let payload = PaymentMethodsGetPayload(terminalCode: "VNSHOP_APP", amount: 20000, orderItems: [.init(sku: "STDVNSHOP05", quantity: 1, price: 20000)])
        Minerva.shared.getPaymentMethods(payload: payload) { result in
            dump(result)
        }
    }
    
    @IBAction func callService(_ sender: Any) {
        let card = CardRequestData(merchantMethodCode: "VNSHOP_VNPAY_GATEWAY",
                            methodCode: "VNPAY_GATEWAY",
                            clientTransactionCode: "client-atransactionn7",
                            amount: 100000,
                            bankCode: "",
                            type: .redirect,
                            token: "")
        let qr = QrRequestData()
        let payload = PaymentAIOPayload(orderCode: "order-code",
                                        userId: "02d1788674b7408395c6fb96f1ccd1f2",
                                        totalPaymentAmount: 100000,
                                        payments: Payments(card: card),
                                        successUrl: "https://teko.vn",
                                        cancelUrl: "https://teko.vn")
        Minerva.shared.initAIOPayment(payload: payload) { result in
            print(result)
        }
    }
    
    @IBAction func openUI(_ sender: Any) {
        let request = PaymentRequest(orderId: "aaa", orderCode: "aaaa", amount: 100000)
        let pm = TerraPayment.default.getPaymentUI(request: request, delegate: self)
        present(pm, animated: true, completion: nil)
    }
    
    func onResult(_ result: PaymentResult) {
        print(result)
    }
    
    func onCancel() {
        print("Cancelled")
    }
    
}

