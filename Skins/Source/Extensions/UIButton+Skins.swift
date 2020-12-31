//
//  UIButton+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UIButton

extension SkinsWrapper where Base: UIButton {
    
    /// tintColor
    public var tintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.tintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /// setTitleColor
    /// - Parameters:
    ///   - color: SKColor
    ///   - state:  UIControl.State
    public func setTitleColor(_ color: SKColor?, for state: UIControl.State) {
        let action = SKAction.init(entity: .color(color, { [weak base] (style, color) in
             base?.setTitleColor(color?.current(with: style), for: state)
        })).run()
        let key: SKAction.Key = .init(string: #function + "\(state.rawValue)")
        Skins.shared.add(action: action, forKey: key, target: base)
    }
    
    /// setTitleShadowColor
    /// - Parameters:
    ///   - color: SKColor
    ///   - state: UIControl.State
    public func setTitleShadowColor(_ color: SKColor?, for state: UIControl.State) {
        let action = SKAction.init(entity: .color(color, { [weak base] (style, color) in
            base?.setTitleShadowColor(color?.current(with: style), for: state)
        })).run()
        let key: SKAction.Key = .init(string: #function + "\(state.rawValue)")
        Skins.shared.add(action: action, forKey: key, target: base)
    }
    
    /// setImage
    /// - Parameters:
    ///   - image: SKImage
    ///   - state: UIControl.State
    public func setImage(_ image: SKImage?, for state: UIControl.State) {
        guard let img = image else {
            base.setImage(nil, for: state)
            return
        }
        let action = SKAction.init(entity: .color(img.color, { [weak base] (style, color) in
            let _img = image?.image?.skin.tint(color: img.color.current(with: style))
            base?.setImage(_img, for: state)
        })).run()
        let key: SKAction.Key = .init(string: #function + "\(state.rawValue)")
        Skins.shared.add(action: action, forKey: key, target: base)
    }
    
    /// setBackgroundImage
    /// - Parameters:
    ///   - image: UIImage
    ///   - state: UIControl.State
    public func setBackgroundImage(_ image: SKImage?, for state: UIControl.State)  {
        guard let img = image else {
            base.setBackgroundImage(nil, for: state)
            return
        }
        let action = SKAction.init(entity: .color(img.color, { [weak base] (style, color) in
            let _img = image?.image?.skin.tint(color: img.color.current(with: style), opaque: img.opaque)
            base?.setBackgroundImage(_img, for: state)
        })).run()
        let key: SKAction.Key = .init(string: #function + "\(state.rawValue)")
        Skins.shared.add(action: action, forKey: key, target: base)
    }
    
}
