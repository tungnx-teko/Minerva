//
//  PaymentObserver.swift
//  Minerva
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation
import FirebaseFirestore

public typealias Transaction = PaymentAIOResponse.PaymentTransaction

public class PaymentObserver {
    
    var databaseManager: DatabaseManager
    
    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }
    
    weak var observation: ListenerRegistration?
    
    public func observe(transaction: Transaction, completion: @escaping (PaymentResult) -> ()) {
        observation = databaseManager
            .transactions?
            .collection(transaction.merchantCode)
            .document(transaction.merchantMethodCode)
            .collection(DatabaseManager.Constants.ipn)
            .document(transaction.transactionCode)
            .addSnapshotListener { snapshot, error in
                if let dictionary = snapshot?.data() {
                    let result = PaymentTransactionResult(fromDict: dictionary)
                    if result.isSuccess {
                        completion(.success(result))
                    } else {
                        completion(.failure(.transaction(error: result.error)))
                    }
                }
        }
    }
    
    public func removeObserver() {
        observation?.remove()
    }
        
}

public struct PaymentTransactionResult {
    
    public var amount: Double?
    public var message: String?
    public var ref: String?
    public var status: String?
    public var transactionCode: String?
    public var orderCode: String?
    public var methodCode: String?
    public var createdTime: Int?
    
    public var isSuccess: Bool {
        return status == "200"
    }
    
    public init(fromDict dict: [String: Any]) {
        self.amount = dict["amount"] as? Double
        self.message = dict["message"] as? String
        self.ref = dict["ref"] as? String
        self.status = dict["status"] as? String
        self.transactionCode = dict["transaction_code"] as? String
        self.orderCode = dict["order_code"] as? String
        self.methodCode = dict["method_code"] as? String
        self.createdTime = dict["created_time"] as? Int
    }
    
    var error: TransactionError {
        guard !isSuccess, let status = self.status, let errorCode = Int(status) else { return .common }
        return TransactionError(code: errorCode)
    }
    
}

public enum TransactionError: Int {
    case common
    case processing
    case paymentProcessed
    case balanceNotEnough
    case paymentCancelled
    case paymentMethodNotSupported
    case outOfStock
    
    public init(code: Int) {
        switch code {
        case 999, 887...895, 882...885, 880, 878, 900...901, 780...782, 699, 501, 499:
            self = .common
        case 886:
            self = .processing
        case 881:
            self = .paymentProcessed
        case 879:
            self = .balanceNotEnough
        case 877:
            self = .paymentCancelled
        case 778...779:
            self = .paymentMethodNotSupported
        case 783:
            self = .outOfStock
        default:
            self = .common
        }
    }
    
}

extension String {
    
    func localized() -> String {
        return self
    }
    
}
