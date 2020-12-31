//
//  UITabBarItemStateAppearance+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import  UIKit.UITabBarAppearance

@available(iOS 13.0, *)
extension SkinsWrapper where Base: UITabBarItemStateAppearance {
    
    
    /// The color to use for item icons. If not specified, a suitable color will be derived.
    public var iconColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.iconColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /// The color to use for the badge background
    public var badgeBackgroundColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.badgeBackgroundColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
}
