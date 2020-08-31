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
        
        let config = PaymentServiceConfig(clientCode: "PVSDK1",
                                          terminalCode: "PE1118CC50322",
                                          serviceCode: "RETAIL",
                                          secretKey: "354deb9bf68088199d8818f71c01951f",
                                          baseUrl: "https://payment.stage.tekoapis.net/api")
        
        PaymentGateway.initialize(withConfig: config, environment: .development)
        
        let ctt = CTTMethod(config: CTTPaymentConfig(), methodCode: MethodCode(name: "CTT", code: "CTT"))
        let spos = SPOSMethod(config: SPOSPaymentConfig(), methodCode: MethodCode(name: "SPOS", code: "SPOSCARD"))
        
        PaymentGateway.setPaymentMethods(methods: [ctt, spos])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

