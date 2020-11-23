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
        static let paymentCollectionPath = "paymentv2"
        static let ipn = "ipn"
    }
        
    var database: Firestore?
    
    lazy var transactions: DocumentReference? = {
        return database?
            .collection(DatabaseManager.Constants.paymentCollectionPath)
            .document(Constants.transactionCollectionPath)
    }()
 
    var appName: String
    var firebaseConfig: FirebaseConfig
    
    init(appName: String = Constants.appName, firebaseConfig: FirebaseConfig) {
        self.appName = appName
        self.firebaseConfig = firebaseConfig
        
        self.setupFirebase(appName: appName, config: firebaseConfig)
        guard let app = FirebaseApp.app(name: appName) else {
            return
        }
        database = Firestore.firestore(app: app)
    }
    
    private func setupFirebase(appName: String, config: FirebaseConfig) {
        let options = FirebaseOptions.init(googleAppID: config.googleAppId,
                                           gcmSenderID: config.gcmSenderId)
        
        options.projectID = config.projectId
        options.apiKey = config.apiKey
        options.databaseURL = config.databaseUrl
        options.storageBucket = config.storageBucket
        
        FirebaseApp.configure(name: appName, options: options)
    }
    
    
}
