//
//  Minerva.swift
//  Minerva
//
//  Created by Tung Nguyen on 7/24/20.
//

import Foundation
import UIKit

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
    }
    
    public static let shared = Minerva()
    
    static var config: PaymentServiceConfig!
    static var environment: Environment = .development
    static var methods: [PaymentMethod] = []
    lazy var paymentService = PaymentService(url: URL(string: Minerva.config.baseUrl)!)
    
    private init() {}
    
    public static func initialize(withConfig config: PaymentServiceConfig, environment: Environment) {
        Minerva.config = config
        Minerva.environment = environment
    }
    
    public static func setPaymentMethods(methods: [PaymentMethod]) {
        Minerva.methods = methods
    }
    
    public func pay(method: PaymentMethod, request: BaseTransactionRequest, completion: @escaping (Result<BaseTransactionResponse, Error>) -> ()) throws {
        guard let _ = Minerva.config else {
            throw PaymentError.missingPaymentConfig
        }
        guard let method = getPaymentMethod(fromCode: method.methodCode.code) else {
            throw PaymentError.methodNotFound
        }
        try paymentService.pay(method: method, request: request, completion: { result in
            completion(result)
        })
    }
    
    private func getPaymentMethod(fromCode code: String) -> PaymentMethod? {
        return Minerva.methods.first { $0.methodCode.code == code }
    }
    
    
    public func getPaymentUI(request: PaymentRequest, delegate: PaymentDelegate) -> PaymentViewController {
        let pm = PaymentRouter.createModule(request: request, delegate: delegate)
        return pm
    }
    
    
}
