//
//  Double+.swift
//  Core
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

extension Double {
    
    var isInteger: Bool {
        return self.truncatingRemainder(dividingBy: 1) == 0
    }
    
    var intValue: Int {
        return Int(self)
    }
    
}
