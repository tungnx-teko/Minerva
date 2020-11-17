//
//  UIColor+.swift
//  Alamofire
//
//  Created by Tung Nguyen on 7/2/20.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIColor {
    class var overlay: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    }
    
    class var neutral02PrimaryText: UIColor {
        return UIColor(red: 89, green: 89, blue: 89)
    }
    
    class var neutral01TitleText: UIColor {
        return UIColor(red: 38, green: 38, blue: 38)
    }
    
    class var secondaryDefault: UIColor {
        return UIColor(red: 6, green: 116, blue: 232)
    }
}
