//
//  AppDelegate.swift
//  Example
//
//  Created by Tung Nguyen on 8/27/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import Minerva

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let dict: [String: Any] = [
            "clientCode": "PVSDK1",
            "terminalCode": "PE1118CC50322",
            "serviceCode": "RETAIL",
            "secretKey": "354deb9bf68088199d8818f71c01951f",
            "baseUrl": "https://payment.stage.tekoapis.net/api",
            "firebaseConfig": [
                "projectId":"payment-test-fc407",
                "applicationId":"1:621256043987:ios:b359f0c782414f1d3f1326",
                "apiKey":"AIzaSyCTMCbvnSPuNG0jk7wW1SRg7gsmYsHbXT0",
                "databaseUrl":"https://payment-test-fc407.firebaseio.com/",
                "storageBucket":"payment-test-fc407.appspot.com",
                "gcmSenderId":"621256043987"
            ]
        ]
        
//        let config = PaymentServiceConfig(clientCode: "PVSDK1",
//                                          terminalCode: "PE1118CC50322",
//                                          serviceCode: "RETAIL",
//                                          secretKey: "354deb9bf68088199d8818f71c01951f",
//                                          baseUrl: "https://payment.stage.tekoapis.net/api")
        
//        PaymentGateway.initialize(withConfig: config, environment: .development)
        
        Minerva.shared.initialize(config: dict)
        
        let ctt = CTTMethod(config: CTTPaymentConfig(), methodCode: CTTMethod.cttCode)
        let spos = SPOSMethod(config: SPOSPaymentConfig(), methodCode: SPOSMethod.sposCode)
        
        Minerva.shared.setPaymentMethods([ctt, spos])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

