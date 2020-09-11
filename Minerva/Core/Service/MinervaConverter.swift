//
//  MinervaConverter.swift
//  Minerva
//
//  Created by Tung Nguyen on 9/11/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import TekCoreService

class MinervaConverter: BaseServiceConverter<PaymentServiceConfig> {
    
    override func convertConfig(rawValue: [String : Any]) -> PaymentServiceConfig {
        return .init(rawValue: rawValue)
    }
    
}

