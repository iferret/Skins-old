//
//  UIImageView+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UIImageView

extension SkinsWrapper where Base: UIImageView {
    
    /// tint color
    public var tintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color}
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.tintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
}
