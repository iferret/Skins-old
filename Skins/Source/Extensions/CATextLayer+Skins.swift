//
//  CATextLayer+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import QuartzCore.CATextLayer

extension SkinsWrapper where Base: CATextLayer {
    
    /* The color object used to draw the text. Defaults to opaque white.
     * Only used when the `string' property is not an NSAttributedString.
     * Animatable (Mac OS X 10.6 and later.) */
    public var foregroundColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.foregroundColor = color?.current(with: style).cgColor
                })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
}
