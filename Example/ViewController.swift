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
    
    lazy var observer = TerraPayment.default.createObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hi")
    }
    
    @IBAction func paymentMethodsWasTapped(_ sender: Any) {
        let payload = PaymentMethodsGetPayload(terminalCode: "VNSHOP_APP",
                                               amount: 20000,
                                               orderItems: [.init(sku: "STDVNSHOP05", quantity: 1, price: 20000)])
        TerraPayment.default.getPaymentMethods(payload: payload) { result in
            dump(result)
        }
    }
    
    @IBAction func callService(_ sender: Any) {
        let card = CardRequestData(merchantMethodCode: "VNSHOP_VNPAY_GATEWAY",
                            methodCode: "VNPAY_GATEWAY",
                            clientTransactionCode: "client-atransactionn-8",
                            amount: 100000,
                            bankCode: "",
                            type: .qrcode,
                            token: "")
        let payload = PaymentAIOPayload(merchantCode: "VNSHOP",
                                        orderCode: "order-code",
                                        userId: "02d1788674b7408395c6fb96f1ccd1f2",
                                        totalPaymentAmount: 100000,
                                        payments: PaymentData(card: card),
                                        successUrl: "https://teko.vn",
                                        cancelUrl: "https://teko.vn")
        
        TerraPayment.default.initAIOPayment(payload: payload) { result in
            switch result {
            case .success(let response):
                self.observer.observe(transaction: response.payments!.card!) { transactionResult in
                    print(transactionResult)
                }
            default: break
            }
            
            
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

