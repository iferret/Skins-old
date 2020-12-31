//
//  CAEmitterCell+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import QuartzCore.CAEmitterCell

extension SkinsWrapper where Base: CAEmitterCell {
    
    /* The mean color of each emitted object, and the range from that mean
     * color. `color' defaults to opaque white, `colorRange' to (0, 0, 0,
     * 0). Animatable. */
    public var color: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.color = color?.current(with: style).cgColor
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
}
