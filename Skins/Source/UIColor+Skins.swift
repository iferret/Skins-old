//
//  UIColor+Extensions.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UIColor

extension UIColor {
    
    /// 构建颜色
    ///
    /// - Parameters:
    ///   - hex: 16 进制
    convenience init(hex: String) {
        var hex = hex
        // 剔除 #
        while hex.hasPrefix("#") {
            hex.removeFirst()
        }
        let colorValue: String
        let alphaValue: CGFloat
        if hex.count == 6 {
            colorValue = .init(hex.prefix(6))
            alphaValue = 1.0
        } else if hex.count > 6 {
            colorValue = .init(hex.prefix(6))
            let value = (hex.suffix(from: colorValue.endIndex) as NSString).intValue
            alphaValue = value > 100 ? 1.0 : (CGFloat(value) / 100.0)
        } else {
            fatalError("Incorrect color value format  value: \(hex)")
        }
        // 构建 Scanner
        let scanner = Scanner(string: colorValue)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        // 扫描
        scanner.scanHexInt64(&rgbValue)
        // 构建参数
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        // 构建 UIColor
        self.init( red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: alphaValue)
        
    }
    
}

extension UIColor {
    
    /// color of skin
    /// - Parameter color: SKColor
    /// - Returns: UIColor
    public static func skin(of color: SKColor) -> UIColor {
        if #available(iOS 13.0, *), Skins.shared.style == .unspecified {
            return UIColor.init { (collection) -> UIColor in
                switch collection.userInterfaceStyle {
                case .light:
                    return color.current(with: .light)
                case .dark:
                    return color.current(with: .dark)
                case .unspecified:
                    return color.current(with: .unspecified)
                @unknown default:
                    return color.current()
                }
            }
        } else {
            return color.current()
        }
    }
}
