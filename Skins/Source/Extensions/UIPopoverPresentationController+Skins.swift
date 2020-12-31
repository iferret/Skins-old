//
//  UIPopoverPresentationController+Skins.swift
//  Skins
//
//  Created by tramp on 2020/7/28.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UIPopoverPresentationController

extension UIPopoverPresentationController: SkinsCompatible {}
extension SkinsWrapper where Base: UIPopoverPresentationController {
    
    // Set popover background color. Set to nil to use default background color. Default is nil.
    public var backgroundColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.backgroundColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
}
