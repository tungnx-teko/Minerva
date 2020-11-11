//
//  PaymentObserver.swift
//  Minerva
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public class PaymentObserver {
    
    var databaseManager: DatabaseManager
    
    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }
    
    public func observe(transactionCode: String, completion: @escaping (PaymentResult) -> ()) {
        databaseManager
            .transactions?
            .document(transactionCode)
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
        
}

public struct PaymentTransactionResult {
    
    public var amount: Double?
    public var message: String?
    public var ref: String?
    public var status: String?
    public var transactionId: String?
    
    public var isSuccess: Bool {
        return status == "000"
    }
    
    public init(fromDict dict: [String: Any]) {
        self.amount = dict["amount"] as? Double
        self.message = dict["message"] as? String
        self.ref = dict["ref"] as? String
        self.status = dict["status"] as? String
        self.transactionId = dict["transaction_id"] as? String
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
