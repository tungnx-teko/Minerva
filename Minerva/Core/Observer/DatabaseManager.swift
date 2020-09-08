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
    let environment = Minerva.environment
    
    var database: Firestore?
    
    var transactions: CollectionReference? {
        return database?
            .collection(DatabaseManager.Constants.paymentCollectionPath)
            .document(Minerva.config.clientCode)
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
        let config = environment.config
        let options = FirebaseOptions.init(googleAppID: config.googleAppID,
                                           gcmSenderID: config.gcmSenderID)
        
        options.projectID = config.projectID
        options.apiKey = config.apiKey
        options.databaseURL = config.databaseURL
        options.storageBucket = config.storageBucket
        
        FirebaseApp.configure(name: DatabaseManager.Constants.appName, options: options)
    }
    
    
}
