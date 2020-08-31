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
    
    public static func paymentUI(request: PaymentRequest, delegate: PaymentDelegate) -> UIViewController {
        let pm = PaymentRouter.createModule(request: request, delegate: delegate)
        return pm
    }
    
}
