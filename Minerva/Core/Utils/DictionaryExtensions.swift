//
//  DictionaryExtensions.swift
//  Pods
//
//  Created by Tung Nguyen on 5/20/20.
//

import Foundation

extension Dictionary where Key == String {
    
    var stringify: String {
        let sortedDict = self.sorted { $0.key < $1.key }
        return sortedDict.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
    
}
