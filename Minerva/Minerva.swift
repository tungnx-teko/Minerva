//
//  Minerva.swift
//  Minerva
//
//  Created by Tung Nguyen on 7/24/20.
//

import Foundation
import UIKit
import TerraInstancesManager

public class Minerva {
    
    public struct Config {
        public static var expireTime: Int                  = 600
    }
    
    public struct Strings {
        public static var closeButtonTitle: String         = "Đóng"
        public static var cancelButtonTitle: String        = "Huỷ"
        public static var paymentSuccessTitle: String      = "Thanh toán thành công"
        public static var paymentFailureTitle: String      = "Thanh toán thất bại"
        public static var transactionCodeTitle: String     = "Mã thanh toán: "
        public static var paymentMethodsTitle: String      = "Phương thức thanh toán"
        public static var paymentQRTitle: String           = "VNPayQR"
        public static var paymentQRMethod: String          = "VNPayQR"
        public static var paymentCTTMethod: String         = "Thẻ (ATM/Debit/Credit...)"
        public static var paymentSPOSMethod: String        = "VNPayPOS"
        public static var paymentCashMethod: String        = "Tiền mặt"
        public static var totalMoneyTitle: String          = "Tổng tiền"
        public static var resultTitle: String              = "Kết quả giao dịch"
        public static var sposWaitingResult: String        = "Đang chờ kết quả giao dịch"
    }
    
    public struct Theme {
        public static var primaryColor: UIColor            = UIColor(red: 235, green: 31, blue: 58)
        public static var navigationViewHeight: CGFloat    = 56
    }
    
    public struct Images {
        public static var backButton: UIImage? = ImagesHelper.imageFor(name: "back")
        public static var sposIcon: UIImage? = ImagesHelper.imageFor(name: "spos")
        public static var qrIcon: UIImage? = ImagesHelper.imageFor(name: "qr")
        public static var cardIcon: UIImage? = ImagesHelper.imageFor(name: "card")
    }
        
    public static let configName = "ps"
    var config: PaymentServiceConfig!
    var databaseManager: DatabaseManager
    var paymentManager: PaymentManager
    var appName: String
    
    public init(appName: String, config: PaymentServiceConfig) {
        self.appName = appName
        self.config = config
        self.databaseManager = DatabaseManager(appName: appName, firebaseConfig: config.firebaseConfig, document: config.clientCode)
        self.paymentManager = PaymentManager(config: config)
        dump(config)
    }
    
    
    // MARK: - public funcs
    public func getPaymentUI(request: PaymentRequest, delegate: PaymentDelegate) -> PaymentViewController {
        let pm = PaymentRouter.createModule(appName: appName, request: request, delegate: delegate)
        return pm
    }

}

// MARK: - public static funcs
extension Minerva {
    public static func configure(appName: String = MinervaSingleton.DEFAULT_VALUE, config: PaymentServiceConfig) -> Minerva {
        let instance = Minerva(appName: appName, config: config)
        instance.config = config
        dump(config)
        return instance
    }
    
    public static func configure(appName: String = MinervaSingleton.DEFAULT_VALUE, config: [String: Any]) -> Minerva {
        let converter = MinervaConverter(input: config)
        return configure(appName: appName, config: converter.output)
    }
    
    public static func configure(app: ITerraApp) -> Minerva {
        let config = app.configGetter?.getConfig(key: Minerva.configName) ?? [:]
        return configure(appName: app.identity, config: config)
    }
}

// MARK: - IPaymentManager
extension Minerva: IPaymentManager {
    var methods: [PaymentMethod] {
        return paymentManager.methods
    }

    public func setPaymentMethods(_ methods: [PaymentMethod]) {
        paymentManager.setPaymentMethods(methods)
    }
    
    public func getPaymentMethods() -> [PaymentMethod] {
        return methods
    }
    
    public func addPaymentMethod(_ method: PaymentMethod) {
        paymentManager.addPaymentMethod(method)
    }
    
    public func clearPaymentMethods() {
        paymentManager.clearPaymentMethods()
    }

    public func pay<T: BaseTransactionRequest>(method: MethodCode, request: T,
                                                completion: @escaping (Result<T.TransactionType, Error>) -> ()) throws {
        try paymentManager.pay(method: method, request: request, completion: completion)
    }
}
