//
//  CAShapeLayer+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import QuartzCore.CAShapeLayer

extension SkinsWrapper where Base: CAShapeLayer {
    
    /* The color to fill the path, or nil for no fill. Defaults to opaque
     * black. Animatable. */
    public var fillColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.fillColor = color?.current(with: style).cgColor
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /* The color to fill the path's stroked outline, or nil for no stroking.
     * Defaults to nil. Animatable. */
    public var strokeColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.strokeColor = color?.current(with: style).cgColor
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
}
