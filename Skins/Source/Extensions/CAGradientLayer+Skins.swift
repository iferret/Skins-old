//
//  CAGradientLayer+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import QuartzCore.CAGradientLayer

extension SkinsWrapper where Base: CAGradientLayer {
    
    
    /* The array of CGColorRef objects defining the color of each gradient
     * stop. Defaults to nil. Animatable. */
    public var colors: [SKColor]? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.colors }
        set {
            let action = SKAction.init(entity: .colors(newValue, { [weak base] (style, colors) in
                base?.colors = colors?.compactMap({ (color) -> CGColor? in
                    return color.current(with: style).cgColor
                })
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
}
