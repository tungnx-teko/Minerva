//
//  PaymentServiceConfig.swift
//  Core
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public class PaymentServiceConfig {
    public var clientCode: String
    public var terminalCode: String
    public var serviceCode: String
    public var secretKey: String
    public var baseUrl: String
    public var firebaseConfig: FirebaseConfig
    
    public init(rawValue: [String: Any]) {
        self.clientCode = (rawValue["clientCode"] as? String) ?? ""
        self.terminalCode = (rawValue["terminalCode"] as? String) ?? ""
        self.serviceCode = (rawValue["serviceCode"] as? String) ?? ""
        self.secretKey = (rawValue["secret"] as? String) ?? ""
        self.baseUrl = (rawValue["url"] as? String) ?? ""
        let firebaseConfigDict = (rawValue["firebaseConfig"] as? [String: Any]) ?? [:]
        self.firebaseConfig = FirebaseConfig(rawValue: firebaseConfigDict)
    }
    
}

public class FirebaseConfig {
    var googleAppId: String
    var gcmSenderId: String
    var projectId: String
    var apiKey: String
    var databaseUrl: String
    var storageBucket: String
    
    public init(rawValue: [String: Any]) {
        self.googleAppId = (rawValue["applicationId"] as? String) ?? ""
        self.gcmSenderId = (rawValue["gcmSenderId"] as? String) ?? ""
        self.projectId = (rawValue["projectId"] as? String) ?? ""
        self.apiKey = (rawValue["apiKey"] as? String) ?? ""
        self.databaseUrl = (rawValue["databaseUrl"] as? String) ?? ""
        self.storageBucket = (rawValue["storageBucket"] as? String) ?? ""
    }
}

