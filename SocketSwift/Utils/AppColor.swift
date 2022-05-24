//
//  AppColor.swift
//  SocketSwift
//
//  Created by regan on 2022/5/18.
//

import Foundation
import UIKit

class AppColor {
    static let Gray01 = "#EFEFEF"
    
    static let Gray02 = "#B9B9B9"
    
    static let Gray03 = "#CCCCCC"
    
    static let Gray04 = "#ECEBEA"
    
    static let Pink01 = "#FEA39B"
    
    static let Pink02 = "#F0607B"
    
    static let Pink03 = "#FFA79A"
    
    static let Blue01 = "#057AFF"
    
    static let Blue02 = "#0A9AC9"
    
    static let Blue03 = "#00C0EF"
    
    static let Blue04 = "#5DB7D4"
    
    static let Blue05 = "#27C6E6"
    
    static let Green01 = "#5DB91D"
    
    static let Green02 = "#2BAB8A"
    
    static let Green03 = "#9BCE0E"
    
    static let Green04 = "#3ABCA7"
    
    static let Green05 = "#4CD964"
    
    static let Orange01 = "#F39C11"
    
    static let Orange02 = "#FFA347"
    
    static let Purple01 = "#8F77AA"
    
    static let Red01 = "#F86955"
    
    static let Red02 = "#E96262"
    
    static let Red03 = "#E85F5F"
    
    static let Yellow01 = "#F7FF9C"
    
    static let Yellow02 = "#FFC337"
    
    static let White01 = "#F9F9F9"
}

extension UIColor {
       convenience init(red: Int, green: Int, blue: Int) {
           assert(red >= 0 && red <= 255, "Invalid red component")
           assert(green >= 0 && green <= 255, "Invalid green component")
           assert(blue >= 0 && blue <= 255, "Invalid blue component")

           self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
       }

       convenience init(rgb: Int) {
           self.init(
               red: (rgb >> 16) & 0xFF,
               green: (rgb >> 8) & 0xFF,
               blue: rgb & 0xFF
           )
       }
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init()
        } else {
            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: CGFloat(1.0))
        }
    }
}
