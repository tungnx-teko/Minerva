//
//  StringExtensions.swift
//  Alamofire
//
//  Created by Tung Nguyen on 5/20/20.
//

import Foundation

extension String {
    
    var isNotEmpty: Bool { return !isEmpty }
    
}

extension Optional where Wrapped == String {
    
    var orEmpty: String {
        return self ?? ""
    }
    
}
