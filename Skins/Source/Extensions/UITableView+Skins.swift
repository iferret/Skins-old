//
//  UITableView+Skins.swift
//  VDiskMobileLite
//
//  Created by tramp on 2020/11/3.
//

import UIKit

extension SkinsWrapper where Base: UITableView {
    
    /// SKColor
    public var separatorColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.separatorColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
}
