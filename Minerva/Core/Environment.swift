//
//  Environment.swift
//  Minerva
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public enum Environment {
    case development
    case production
    
    var config: FirebaseConfig {
        switch self {
        case .development:
            return FirebaseConfig.development
        case .production:
            return FirebaseConfig.production
        }
    }
}

class FirebaseConfig {
    var googleAppID: String
    var gcmSenderID: String
    var projectID: String
    var apiKey: String
    var databaseURL: String
    var storageBucket: String
    
    init(googleAppID: String, gcmSenderID: String, projectID: String, apiKey: String, databaseURL: String, storageBucket: String) {
        self.googleAppID = googleAppID
        self.gcmSenderID = gcmSenderID
        self.projectID = projectID
        self.apiKey = apiKey
        self.databaseURL = databaseURL
        self.storageBucket = storageBucket
    }
    
    static let development = FirebaseConfig(googleAppID: "1:621256043987:ios:b359f0c782414f1d3f1326",
                                            gcmSenderID: "621256043987",
                                            projectID: "payment-test-fc407",
                                            apiKey: "AIzaSyCTMCbvnSPuNG0jk7wW1SRg7gsmYsHbXT0",
                                            databaseURL: "https://payment-test-fc407.firebaseio.com/",
                                            storageBucket: "payment-test-fc407.appspot.com")
    
    static let production = FirebaseConfig(googleAppID: "", gcmSenderID: "",
                                           projectID: "", apiKey: "",
                                           databaseURL: "", storageBucket: "")
}

