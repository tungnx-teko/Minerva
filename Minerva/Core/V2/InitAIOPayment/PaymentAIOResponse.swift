//
//  PaymentAIOResponse.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/9/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import TekCoreNetwork

public class PaymentAIOResponse: BaseResponse<PaymentCodeV2> {
    public var message: String?
    public var orderCode: String?
    public var payments: PaymentsData?
    public var merchantCode: String = ""
    
    enum CodingKeys: String, CodingKey {
        case message, orderCode, payments
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderCode = try values.decodeIfPresent(String.self, forKey: .orderCode)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        payments = try values.decodeIfPresent(PaymentsData.self, forKey: .payments)
        try super.init(from: decoder)
    }
    
    public class PaymentsData: Decodable {
        public var credit: PaymentTransaction?
        public var loyalty: PaymentTransaction?
        public var qr: PaymentTransaction?
        public var card: PaymentTransaction?
        
        enum CodingKeys: String, CodingKey {
            case credit, loyalty, qr, card
        }
        
        required public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            credit = try values.decodeIfPresent(PaymentTransaction.self, forKey: .credit)
            loyalty = try values.decodeIfPresent(PaymentTransaction.self, forKey: .loyalty)
            qr = try values.decodeIfPresent(PaymentTransaction.self, forKey: .qr)
            card = try values.decodeIfPresent(PaymentTransaction.self, forKey: .card)
        }
    }
    
    public class PaymentTransaction: Decodable {
        public var clientTransactionCode: String
        public var transactionCode: String
        public var methodCode: String
        public var responseCode: String?
        public var responseMessage: String?
        public var qrContent: String?
        public var returnUrl: String?
        public var traceId: String
        public var merchantMethodCode: String = ""
        public var merchantCode: String = ""
        
        enum CodingKeys: String, CodingKey {
            case clientTransactionCode, transactionCode, methodCode, responseCode, responseMessage, qrContent, returnUrl, traceId
        }
        
        required public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            clientTransactionCode = try values.decodeIfPresent(String.self, forKey: .clientTransactionCode) ?? ""
            transactionCode = try values.decodeIfPresent(String.self, forKey: .transactionCode) ?? ""
            methodCode = try values.decodeIfPresent(String.self, forKey: .methodCode) ?? ""
            responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
            responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
            qrContent = try values.decodeIfPresent(String.self, forKey: .qrContent)
            returnUrl = try values.decodeIfPresent(String.self, forKey: .returnUrl)
            traceId = try values.decodeIfPresent(String.self, forKey: .traceId) ?? ""
        }
    }
    
}

