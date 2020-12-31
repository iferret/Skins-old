//
//  UITabbar+Skins.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UITabBar

extension SkinsWrapper where Base: UITabBar {
    
    /*
     The behavior of tintColor for bars has changed on iOS 7.0. It no longer affects the bar's background
     and behaves as described for the tintColor property added to UIView.
     To tint the bar's background, please use -barTintColor.
     */
    @available(iOS 5.0, *)
    public var tintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.tintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    @available(iOS 7.0, *)
    public var barTintColor:  SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.barTintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /// Unselected items in this tab bar will be tinted with this color. Setting this value to nil indicates that UITabBar should use its default value instead.
    @available(iOS 10.0, *)
    public var unselectedItemTintColor:  SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.unselectedItemTintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    
    /* selectedImageTintColor will be applied to the gradient image used when creating the
     selected image. Default is nil and will result in the system bright blue for selected
     tab item images. If you wish to also customize the unselected image appearance, you must
     use the image and selectedImage properties on UITabBarItem along with UIImageRenderingModeAlways
     
     Deprecated in iOS 8.0. On iOS 7.0 and later the selected image takes its color from the
     inherited tintColor of the UITabBar, which may be set separately if necessary.
     */
    @available(iOS, introduced: 5.0, deprecated: 8.0)
    public var selectedImageTintColor:  SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.selectedImageTintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
}
