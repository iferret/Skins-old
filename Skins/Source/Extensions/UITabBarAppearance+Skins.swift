//
//  UITabBarAppearance+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UITabBarAppearance

@available(iOS 13.0, *)
extension SkinsWrapper where Base: UITabBarAppearance {
    
    /// A color to use for the selectionIndicator, its specific behavior depends on the value of selectionIndicatorImage. If selectionIndicatorImage is nil, then the selectionIndicatorTintColor is used to color the UITabBar's default selection indicator; a nil or clearColor selectionIndicatorTintColor will result in no indicator. If selectionIndicatorImage is a template image, then the selectionIndicatorTintColor is used to tint the image; a nil or clearColor selectionIndicatorTintColor will also result in no indicator. If the selectionIndicatorImage is not a template image, then it will be rendered without respect to the value of selectionIndicatorTintColor.
    public var selectionIndicatorTintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.selectionIndicatorTintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
}
