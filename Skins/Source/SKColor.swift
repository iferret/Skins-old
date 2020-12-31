//
//  SKColor.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UIColor

/*
 <key>major</key>
 <dict>
     <key>light</key>
     <string>#169BD5</string>
     <key>dark</key>
     <string>#169BD5</string>
 </dict>
 */

/// SKColorKey
public typealias SKColorKey = String

/// SKColorable
public protocol SKColorable {

    /// 获取当前适配颜色
    /// - Parameter style: Skins.UserInterfaceStyle
    func current(with style: Skins.UserInterfaceStyle) -> UIColor
}



/// SKColor
public struct SKColor: Decodable {
    /// light color hex value
    public let light: String
    /// dark color hex value
    public let dark: String
    
    /// 构建
    /// - Parameters:
    ///   - light: String
    ///   - dark: String
    public init(light: String, dark: String) {
        self.light = light
        self.dark = dark
    }
}

// MARK: - SKColorable
extension SKColor: SKColorable {
    /// 获取当前适配颜色
    /// - Parameter style: Skins.UserInterfaceStyle
    /// - Returns: UIColor
    public func current(with style: Skins.UserInterfaceStyle = .current) -> UIColor {
        if #available(iOS 13.0, *), style == .unspecified {
            return UITraitCollection.current.userInterfaceStyle == .dark ? UIColor.init(hex: dark) : UIColor.init(hex: light)
        } else {
            return style == .dark ? UIColor.init(hex: dark) : UIColor.init(hex: light)
        }
    }
}
