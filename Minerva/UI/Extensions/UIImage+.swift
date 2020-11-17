//
//  UIImage+.swift
//  Pods
//
//  Created by Tung Nguyen on 6/29/20.
//

import UIKit

public class ImagesHelper {
    
    private static var podsBundle: Bundle {
        let bundle = Bundle(for: ImagesHelper.self)
        return Bundle(url: bundle.url(forResource: "images",
                                      withExtension: "bundle")!)!
    }
    
    public static func imageFor(name imageName: String) -> UIImage? {
        return UIImage(named: imageName, in: podsBundle, compatibleWith: nil)
    }
    
    public static func assestFor(name imageName: String) -> UIImage? {
        let bundle = Bundle(for: ImagesHelper.self)
        return UIImage(named: imageName, in: bundle, compatibleWith: nil)
    }
    
    class func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
}

extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
