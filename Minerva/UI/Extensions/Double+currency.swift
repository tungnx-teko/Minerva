//
//  Double+.swift
//  Pods
//
//  Created by Tung Nguyen on 7/7/20.
//

import Foundation

extension Double {
    func toCurrencyString() -> String? {
        let formatter = NumberFormatter()
        if #available(iOS 11.0, *) {
            formatter.numberStyle = .currency
        } else {
            formatter.numberStyle = .currencyAccounting
        }
        formatter.locale = Locale(identifier: "vi_VN")
        let result = formatter.string(from: NSNumber(value: self)) ?? ""
        let spaceOfApple = " "
        return result.replacingOccurrences(of: spaceOfApple, with: "")
    }
}
