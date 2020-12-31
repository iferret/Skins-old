//
//  UISearchBar+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UISearchBar

extension SkinsWrapper where Base: UISearchBar {
    
    /*
     The behavior of tintColor for bars has changed on iOS 7.0. It no longer affects the bar's background
     and behaves as described for the tintColor property added to UIView.
     To tint the bar's background, please use -barTintColor.
     */
    /// tintColor
    public var tintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.tintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /// barTintColor
    @available(iOS 7.0, *)
    public var barTintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.barTintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
}
