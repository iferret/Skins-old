//
//  CAReplicatorLayer+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import QuartzCore.CAReplicatorLayer

extension SkinsWrapper where Base: CAReplicatorLayer {
    
    /* The color to multiply the first object by (the source object). Defaults
     * to opaque white. Animatable. */
    public var instanceColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.instanceColor = color?.current(with: style).cgColor
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
}
