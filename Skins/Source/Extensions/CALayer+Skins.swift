//
//  CALayer+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import QuartzCore.CALayer

extension CALayer: SkinsCompatible {}
extension SkinsWrapper where Base: CALayer {
    
    /* The background color of the layer. Default value is nil. Colors
     * created from tiled patterns are supported. Animatable. */
    public var backgroundColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.backgroundColor = color?.current(with: style).cgColor
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /* The color of the layer's border. Defaults to opaque black. Colors
     * created from tiled patterns are supported. Animatable. */
    public var borderColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.borderColor = color?.current(with: style).cgColor
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /* The color of the shadow. Defaults to opaque black. Colors created
     * from patterns are currently NOT supported. Animatable. */
    /** Shadow properties. **/
    public var shadowColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.shadowColor = color?.current(with: style).cgColor
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
}
