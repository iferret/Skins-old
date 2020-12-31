//
//  UIContextualAction+Skins.swift
//  VDiskMobileLite
//
//  Created by tramp on 2020/11/24.
//

import Foundation
import UIKit

extension UIContextualAction: SkinsCompatible {}
extension SkinsWrapper where Base: UIContextualAction {
    
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
