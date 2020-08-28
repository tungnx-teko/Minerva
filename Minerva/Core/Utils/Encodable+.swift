//
//  Encodable+.swift
//  Core
//
//  Created by Tung Nguyen on 8/20/20.
//

import Foundation

public extension Encodable {
    
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
    }
    
    func stringify(withChecksum: Bool = false) -> String {
        var dict = self.dictionary
        if !withChecksum {
            dict.removeValue(forKey: "checksum")
        }
        return dict.stringify
    }
    
}
