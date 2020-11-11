//
//  TerraPaymentDatabase.swift
//  Minerva
//
//  Created by linhvt on 11/11/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import TerraInstancesManager

class TerraPaymentDatabase {
    
    static func getInstances(by app: ITerraApp) -> DatabaseManager? {
        return TerraPayment.getInstance(by: app)?.databaseManager
    }
    
    static var `default`: DatabaseManager {
        guard let instance = TerraPayment.instances[MinervaSingleton.DEFAULT_VALUE] else {
            fatalError("Must configure Minerva with config before using default instance")
        }
        return instance.databaseManager
    }
}
