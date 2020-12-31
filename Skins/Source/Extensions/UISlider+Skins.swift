//
//  UISlider+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UISlider

extension SkinsWrapper where Base: UISlider {
    
    /// minimumTrackTintColor
    @available(iOS 5.0, *)
    public var minimumTrackTintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.minimumTrackTintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /// maximumTrackTintColor
    @available(iOS 5.0, *)
    public var maximumTrackTintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.maximumTrackTintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /// thumbTintColor
    @available(iOS 5.0, *)
    public var thumbTintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.thumbTintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
}
