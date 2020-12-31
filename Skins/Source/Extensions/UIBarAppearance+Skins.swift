//
//  UIBarAppearance+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UIBarAppearance

@available(iOS 13.0, *)
extension SkinsWrapper where Base: UIBarAppearance {
    
    /// A color to use for the bar background. This color is composited over backgroundEffects.
    public var backgroundColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.backgroundColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /// A color to use for the shadow. Its specific behavior depends on the value of shadowImage. If shadowImage is nil, then the shadowColor is used to color the bar's default shadow; a nil or clearColor shadowColor will result in no shadow. If shadowImage is a template image, then the shadowColor is used to tint the image; a nil or clearColor shadowColor will also result in no shadow. If the shadowImage is not a template image, then it will be rendered regardless of the value of shadowColor.
    public var shadowColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.shadowColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
}
