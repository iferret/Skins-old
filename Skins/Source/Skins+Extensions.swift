//
//  Skinable.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation

/// SkinsCompatible
public protocol SkinsCompatible: AnyObject {}
extension SkinsCompatible {
    /// SkinsWrapper<Self>
    public var skin: SkinsWrapper<Self> {
        get { .init(self) }
        set {}
    }
}

/// SkinsCompatibleValue
public protocol SkinsCompatibleValue {}
extension SkinsCompatibleValue {
    /// SkinsWrapper<Self>
    public var skin: SkinsWrapper<Self> {
        get { .init(self) }
        set {}
    }
}

/// SkinsWrapper
public struct SkinsWrapper<Base> {
    /// Base
    public let base: Base
    /// 构建
    /// - Parameter base: Base
    public init(_ base: Base) {
        self.base = base
    }
}


extension Skins {
    
    /// will change
    public static var userInterfaceStyleWillChanged: Notification.Name {
        return .init("Skins.userInterfaceStyleWillChange")
    }
    
    /// did changed
    public static var userInterfaceStyleDidChanged: Notification.Name  {
        return .init("Skins.userInterfaceStyleDidChanged")
    }
}
