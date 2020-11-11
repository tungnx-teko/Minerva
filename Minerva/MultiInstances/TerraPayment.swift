//
//  TerraPayment.swift
//  Minerva
//
//  Created by linhvt on 11/11/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import TerraInstancesManager
import UIKit

public typealias MinervaConfig = PaymentServiceConfig

public class MinervaGenerator: InstanceGeneratable {
    public typealias InstanceType = Minerva
    
    required public init() {}
    
    public func generateInstance(app: ITerraApp) -> Minerva? {
        return Minerva.configure(app: app)
    }
    
    public func generateDefaultInstance(config: MinervaConfig) -> Minerva {
        return Minerva.configure(config: config)
    }
    
    public func generateDefaultInstance(config: [String : Any]) -> Minerva {
        return Minerva.configure(config: config)
    }

}

public class MinervaSingleton: InstancesManageable {
    public typealias Generator = MinervaGenerator
        
    public static var shared = MinervaSingleton()
    
    public var instances: [String : Minerva] = [:]

    // MARK: - for default instance in case using without ITerraApp
    public static let DEFAULT_VALUE = "DEFAULT_MINERVA"
    
    public var `default`: Minerva {
        print("Processing with Minerva default instance!")
        guard let instance = instances[MinervaSingleton.DEFAULT_VALUE] else {
            fatalError("Must configure Minerva with config before using default instance")
        }
        return instance
    }
    
    public func configureWith(config: MinervaConfig) {
        let instance = Generator().generateDefaultInstance(config: config)
        instances[MinervaSingleton.DEFAULT_VALUE] = instance
    }
    
    public func configureWith(config: [String : Any]) {
        let instance = Generator().generateDefaultInstance(config: config)
        instances[MinervaSingleton.DEFAULT_VALUE] = instance
    }
        
    public func configureWith(app: ITerraApp) {
        let _ = TerraPayment.getInstance(by: app)
    }

    
}

public var TerraPayment = MinervaSingleton.shared

