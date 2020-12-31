//
//  SKAction.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UIView

extension SKAction {
    public enum Entity {
        case color(_ color: SKColor?, _ handle: (_ style: Skins.UserInterfaceStyle, _ color: SKColor?) -> Void)
        case colors(_ colors: [SKColor]?, _ handle: (_ style: Skins.UserInterfaceStyle, _ colors: [SKColor]?) -> Void)
    }
}

public class SKAction: NSObject {
    public typealias Key = NSString
    
    /// SKColor
    public var color: SKColor? {
        guard case let Entity.color(value, _) = entity else { return nil }
        return value
    }
    
    ///  [SKColor]?
    public var colors: [SKColor]? {
        guard case let Entity.colors(value, _) = entity else { return nil }
        return value
    }
    
    /// 实体
    private let entity: Entity
    
    // MARK: - 生命周期
    public init(entity: Entity) {
        self.entity = entity
    }
    
    /// run action
    /// - Parameter animated:  animated
    @discardableResult
    public func run(style: Skins.UserInterfaceStyle = Skins.shared.style, animated: Bool = true) -> Self {
        if animated == true {
            UIView.animate(withDuration: Skins.shared.duration) {
                switch self.entity {
                case .color(let color, let handle):
                    handle(style, color)
                case .colors(let colors, let handle):
                    handle(style, colors)
                }
            }
        } else {
            UIView.setAnimationsEnabled(false)
            switch self.entity {
            case .color(let color, let handle):
                handle(style, color)
            case .colors(let colors, let handle):
                handle(style, colors)
            }
            UIView.setAnimationsEnabled(true)
        }
        return self
    }
}
