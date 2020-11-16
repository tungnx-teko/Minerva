//
//  OrderItem.swift
//  Minerva
//
//  Created by Tung Nguyen on 11/10/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public struct OrderItem: Encodable {
    // Product sku
    var sku: String
    
    // Product quantity
    var quantity: Int
    
    // Product price before applying promotions
    var price: Int
    
    public init(sku: String, quantity: Int, price: Int) {
        self.sku = sku
        self.quantity = quantity
        self.price = price
    }
}
