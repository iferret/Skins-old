//
//  UITabBarItem+Skins.swift
//  Skins
//
//  Created by tramp on 2020/7/28.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UITabBarItem

extension UITabBarItem: SkinsCompatible {}
extension SkinsWrapper where Base: UITabBarItem {
    
    /// If this item displays a badge, this color will be used for the badge's background. If set to nil, the default background color will be used instead.
    @available(iOS 10.0, *)
    public var badgeColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, { [weak base] (style, color) in
                base?.badgeColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    /// 设置常规图片
    /// - Parameters:
    ///   - image: UIImage
    ///   - tintColor: SKColor
    public func setImage(_ image: UIImage?, tintColor: SKColor) {
        if let image = image {
            let action = SKAction.init(entity: .color(tintColor, { [weak base] (style, color) in
                let color = tintColor.current(with: style)
                /// begin image context
                UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
                // set color
                color.setFill()
                /// draw image on context
                image.draw(in: CGRect.init(origin: .zero, size: image.size))
                // get image from conext
                let img = UIGraphicsGetImageFromCurrentImageContext()
                // close image context
                UIGraphicsEndImageContext()
                // set image
                base?.image = img?.withRenderingMode(.alwaysOriginal)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        } else {
            base.image = image
        }
    }
    
    /// 获取常规图片
    public var image: UIImage? { return base.image  }
    
    /// 设置选中图片
    /// - Parameters:
    ///   - image: UIImage
    ///   - tintColor: SKColor
    public func setSelectedImage(_ image: UIImage?, tintColor: SKColor) {
        if let image = image {
            let action = SKAction.init(entity: .color(tintColor, { [weak base] (style, color) in
                let color = tintColor.current(with: style)
                /// begin image context
                UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
                // set color
                color.setFill()
                /// draw image on context
                image.draw(in: CGRect.init(origin: .zero, size: image.size))
                // get image from conext
                let img = UIGraphicsGetImageFromCurrentImageContext()
                // close image context
                UIGraphicsEndImageContext()
                // set selected image
                base?.selectedImage = img?.withRenderingMode(.alwaysOriginal)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        } else {
            base.selectedImage = image
        }
    }
    
    /// 获取常规图片
    public var selectedImage: UIImage? { return base.selectedImage  }
}
