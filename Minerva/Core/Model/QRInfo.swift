//
//  QRInfo.swift
//  Minerva
//
//  Created by Anh Tran on 16/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

struct QRInfo {
    let bankAccNo: String
    let bankName: String
    let bankCode: String
    let accName: String
    let phoneNumber: String
    let amount: Double
    let discountCode: String
    let note: String
    let orderCode: String
    
    func toInfoItems() -> [InfoItem] {
        let name = InfoItem(title: Minerva.Strings.customerName, value: accName)
        let phone = InfoItem(title: Minerva.Strings.phoneNumber, value: phoneNumber)
        let bank = InfoItem(title: Minerva.Strings.bankName, value: bankName)
        let discount = InfoItem(title: Minerva.Strings.discountCode, value: discountCode)
        let order = InfoItem(title: Minerva.Strings.orderCode, value: orderCode)
        let amountOrder = InfoItem(title: Minerva.Strings.customerName, value: amount.toCurrencyString() ?? "")
        let discountAmount = InfoItem(title: Minerva.Strings.discountAmount, value: amount.toCurrencyString() ?? "")
        let realAmount = InfoItem(title: Minerva.Strings.realAmount, value: amount.toCurrencyString() ?? "")
        let noteItem = InfoItem(title: Minerva.Strings.note, value: note)
        return [name, phone, bank, discount, order, amountOrder, discountAmount, realAmount, noteItem]
    }
    
    static func test() -> QRInfo {
        return QRInfo(bankAccNo: "Agribank001", bankName: "Agribank", bankCode: "10001", accName: "Nguyễn Thị Thuỳ", phoneNumber: "098****232", amount: 100000, discountCode: "VNPay10", note: "Thanh toán đơn hàng", orderCode: "12345678")
    }
}
