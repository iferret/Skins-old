//
//  UIAlertController+Skins.swift
//  Skins
//
//  Created by tramp on 2020/7/28.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UIAlertController

extension UIAlertController: SkinsCompatible {}
extension SkinsWrapper where Base: UIAlertController {
    
    /// SKColor
    public var tintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.view.tintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
}
