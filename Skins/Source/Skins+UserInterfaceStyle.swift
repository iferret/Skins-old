//
//  Skins+UserInterfaceStyle.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UIInterface

extension Skins {
    
    /// Skins.UserInterfaceStyle
    public enum UserInterfaceStyle: Int {
        @available(iOS 13.0, *)
        case unspecified = 0
        case light = 1
        case dark = 2
    }
}

extension Skins.UserInterfaceStyle {
    
    /// 获取当前 UserInterfaceStyle
    public static var current: Skins.UserInterfaceStyle {
        guard let userdefaults = UserDefaults.init(suiteName: "skins.userdefaults") else {
            if #available(iOS 13.0, *) {
                return .unspecified
            } else {
                return .light
            }
        }
        let key = "skins.current.style.key"
        userdefaults.register(defaults: [key: -1])
        let value = userdefaults.integer(forKey: key)
        guard let style = Skins.UserInterfaceStyle.init(rawValue: value) else {
            if #available(iOS 13.0, *) {
                userdefaults.set(Skins.UserInterfaceStyle.unspecified.rawValue, forKey: key)
                userdefaults.synchronize()
                return .unspecified
            } else {
                userdefaults.set(Skins.UserInterfaceStyle.light.rawValue, forKey: key)
                userdefaults.synchronize()
                return .light
            }
        }
        return style
    }
    
    /// store current style
    /// - Parameter style:  Skins.UserInterfaceStyle
    internal static func store(currentStyle style: Skins.UserInterfaceStyle) {
        guard let userdefaults = UserDefaults.init(suiteName: "skins.userdefaults") else { return }
        let key = "skins.current.style.key"
        userdefaults.set(style.rawValue, forKey: key)
        userdefaults.synchronize()
    }
}

extension Skins.UserInterfaceStyle {
    
    /// UIUserInterfaceStyle
    @available(iOS 12.0, *)
    public var uiStyle: UIUserInterfaceStyle {
        return UIUserInterfaceStyle.init(rawValue: rawValue) ?? .unspecified
    }
    
}
