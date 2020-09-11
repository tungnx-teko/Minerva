//
//  DatabaseManager.swift
//  Minerva
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

class DatabaseManager {
    
    struct Constants {
        static let appName = "payment-gateway"
        static let transactionCollectionPath = "transactions"
        static let paymentCollectionPath = "payment"
    }
    
    static let shared = DatabaseManager()
    
    var database: Firestore?
    
    var transactions: CollectionReference? {
        return database?
            .collection(DatabaseManager.Constants.paymentCollectionPath)
            .document(Minerva.shared.config.clientCode)
            .collection(DatabaseManager.Constants.transactionCollectionPath)
    }
    
    private init() {
        self.setupFirebase()
        
        guard let app = FirebaseApp.app(name: DatabaseManager.Constants.appName) else {
            return
        }
        database = Firestore.firestore(app: app)
    }
    
    private func setupFirebase() {
        let config = Minerva.shared.config.firebaseConfig
        let options = FirebaseOptions.init(googleAppID: config.googleAppId,
                                           gcmSenderID: config.gcmSenderId)
        
        options.projectID = config.projectId
        options.apiKey = config.apiKey
        options.databaseURL = config.databaseUrl
        options.storageBucket = config.storageBucket
        
        FirebaseApp.configure(name: DatabaseManager.Constants.appName, options: options)
    }
    
    
}
