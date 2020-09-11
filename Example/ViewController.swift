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

    @IBAction func callService(_ sender: Any) {
        
    }
    
    @IBAction func openUI(_ sender: Any) {
        let request = PaymentRequest(orderId: "aaa", orderCode: "aaaa", amount: 100000)
        let pm = Minerva.shared.getPaymentUI(request: request, delegate: self)
        present(pm, animated: true, completion: nil)
    }
    
    func onResult(_ result: PaymentResult) {
        print(result)
    }
    
    func onCancel() {
        print("Cancelled")
    }
    
    
}

