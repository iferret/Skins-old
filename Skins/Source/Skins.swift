//
//  Skin.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation
import UIKit.UIInterface

/// Skin
final public class Skins: NSObject {
    
    // MARK: - 公开属性
    
    /// 单例对象
    public static let shared: Skins = .init()
    ///  公开属性
    public private(set) var style: UserInterfaceStyle
    /// 动画周期
    public var duration: TimeInterval = 0.25
    
    /// 是否是亮色模式
    public var isLight: Bool {
        switch style {
        case .unspecified:
            if #available(iOS 13.0, *) {
                return UITraitCollection.current.userInterfaceStyle == .light
            } else {
                fatalError()
            }
        case .light: return true
        case .dark: return false
        }
    }
    
    // MARK: - 私有属性
    
    /// NSMapTable<NSObject, NSMapTable<SKAction.Key, SKAction>>
    private lazy var weaks: NSMapTable<AnyObject, NSMapTable<SKAction.Key, SKAction>> = {
        let _map = NSMapTable<AnyObject, NSMapTable<SKAction.Key, SKAction>>.init(keyOptions: .weakMemory, valueOptions: .strongMemory)
        return _map
    }()
    /// 查询表
    private lazy var map: [SKColorKey: SKColor] = [:]
    /// DispatchSemaphore
    private lazy var semaphore: DispatchSemaphore = .init(value: 1)
    // observers
    private lazy var observers: NSSet = .init()
    
    // MARK: - 生命周期
    
    /// 构建
    private override init() {
        style = UserInterfaceStyle.current
        super.init()
        if #available(iOS 13.0, *) {
            if let method_1 = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.traitCollectionDidChange(_:))),
               let method_2 = class_getInstanceMethod(Skins.self, #selector(Skins.traitCollectionDidChange(_:))) {
                method_exchangeImplementations(method_1, method_2)
            }
        }
        // 监听通知 willEnterForegroundNotification
        let observer = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) {[weak self] (_) in
            guard let this = self else { return }
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.forEach {
                    guard $0.overrideUserInterfaceStyle != this.style.uiStyle else { return }
                    $0.overrideUserInterfaceStyle = this.style.uiStyle
                }
            }
        }
        observers.adding(observer)
    }
    
    /// traitCollectionDidChange
    /// - Parameter previousTraitCollection: UITraitCollection
    @available(iOS 13.0, *)
    @objc dynamic func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        Skins.shared.perform(#selector(Skins.traitCollectionDidChange(_:)), with: previousTraitCollection) // 方法交换后的结果， 运行时执行 UIWindow.traitCollectionDidChange(_:)
        if Skins.shared.style == .unspecified, UITraitCollection.current.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            Skins.shared.change(style: .unspecified, force: true, animated: false) // 方法交换后，此时的 self 为 UIView , 所以需要方法  Skins.shared.change（）， 而不是 self.change()
        }
    }
    
    /// 析构函数
    deinit {
        observers.forEach { (observer) in
            NotificationCenter.default.removeObserver(observer)
        }
    }
}

extension Skins {
    
    /// setup
    /// - Parameters:
    ///   - style: UserInterfaceStyle
    ///   - fileUrl: url of skin plist file
    /// - Throws: UserInterfaceStyle
    public func setup(withStyle style: UserInterfaceStyle, fileUrl: URL) throws {
        guard let dict = NSDictionary.init(contentsOf: fileUrl) as? [String: [String: String]] else { throw SKError.init(message: "can't find the current plist file of skins ...")}
        for (key, value) in dict {
            let data = try JSONSerialization.data(withJSONObject: value, options: [])
            let color = try JSONDecoder.init().decode(SKColor.self, from: data)
            map[key] = color
        }
        self.style = style
        // store current style
        UserInterfaceStyle.store(currentStyle: style)
    }
    
    /// setup
    /// - Parameters:
    ///   - style: UIUserInterfaceStyle
    ///   - fileUrl: url of skin plist file
    ///   - colorType: Decodable&SKColorable
    /// - Throws: UserInterfaceStyle
    @available(iOS 13.0, *)
    public func setup(withUIStyle style: UIUserInterfaceStyle, fileUrl: URL) throws {
        guard let style = UserInterfaceStyle.init(rawValue: style.rawValue) else { throw SKError.init(message: "Does not support current style ...") }
        try setup(withStyle: style, fileUrl: fileUrl)
    }
    
    /// 更新主题样式
    /// - Parameters:
    ///   - uistyle: UIUserInterfaceStyle
    ///   - animated: 是否开启动画
    /// - Throws: Error
    @available(iOS 13.0, *)
    public func change(uistyle: UIUserInterfaceStyle, animated: Bool = true) throws {
        guard let style = UserInterfaceStyle.init(rawValue: uistyle.rawValue) else { throw SKError.init(message: "Does not support current style ...") }
        change(style: style, animated: animated)
    }
    
    /// 更新主题样式
    /// - Parameters:
    ///   - style: UserInterfaceStyle
    ///   - animated: 是否开启动画
    public func change(style: UserInterfaceStyle, animated: Bool = true) {
        change(style: style, force: false, animated: animated)
    }
    
    /// 更新主题样式
    /// - Parameters:
    ///   - style: UserInterfaceStyle
    ///   - animated: 是否开启动画
    private func change(style: UserInterfaceStyle, force: Bool, animated: Bool = true) {
        // print(#function)
        guard self.style != style || force == true  else { return }
        // userInterfaceStyleWillChanged
        NotificationCenter.default.post(name: Skins.userInterfaceStyleWillChanged, object: self, userInfo: ["style": style])
        // change style
        self.style = style
        UserInterfaceStyle.store(currentStyle: style)
        // update ui
        guard let weaks = weaks as? NSMapTable<AnyObject, AnyObject> else { return }
        let keys = NSAllMapTableKeys(weaks).reversed() as [AnyObject]
        for key in keys {
            guard let map = map(of: key) as? NSMapTable<AnyObject, AnyObject> else { continue }
            guard  let actions = NSAllMapTableValues(map) as? [SKAction] else { continue }
            for action in actions.reversed() {
                action.run(animated: animated)
            }
        }
        //  适配iOS 13.0 +
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.forEach {
                guard $0.overrideUserInterfaceStyle != style.uiStyle else { return }
                if animated == true {
                    $0.overrideUserInterfaceStyle = style.uiStyle
                } else {
                    UIView.setAnimationsEnabled(false)
                    $0.overrideUserInterfaceStyle = style.uiStyle
                    UIView.setAnimationsEnabled(true)
                }
            }
        }
        // userInterfaceStyleDidChanged
        NotificationCenter.default.post(name: Skins.userInterfaceStyleDidChanged, object: self, userInfo: ["style": style])
    }
    
    /// debug
    public func debug() {
        guard let weaks = weaks as? NSMapTable<AnyObject, AnyObject> else { return }
        print("weaks keys count =>", NSAllMapTableKeys(weaks).count)
        print("weaks values count =>", NSAllMapTableValues(weaks).count)
    }
    
}

// MARK: -  custom
extension Skins {
    
    /// color for key
    /// - Parameter key: SKColorKey
    /// - Returns: SKColorable
    public func color(forKey key: SKColorKey) -> SKColor {
        guard let color = map[key] else { fatalError("You should configure the color info ...") }
        return color
    }
    
}

// MARK: - operations for maps
extension Skins {
    
    /// add action
    /// - Parameters:
    ///   - action: SKAction
    ///   - key: SKAction.Key
    ///   - target: NSObject
    internal func add(action: SKAction, forKey key: SKAction.Key, target: NSObject) {
        objc_sync_enter(self)
        if let map = weaks.object(forKey: target) {
            map.setObject(action, forKey: key)
        } else {
            let map = NSMapTable<SKAction.Key, SKAction>.init(keyOptions: .strongMemory, valueOptions: .strongMemory)
            map.setObject(action, forKey: key)
            weaks.setObject(map, forKey: target)
        }
        objc_sync_exit(self)
    }
    
    /// remove action
    /// - Parameters:
    ///   - key:  SKAction.Key
    ///   - target: NSObject
    internal func removeAction(withKey key: SKAction.Key, target: NSObject) {
        removeActions(withKeys: [key], target: target)
    }
    
    /// remove actions of target object
    /// - Parameters:
    ///   - keys: [SKAction.Key]
    ///   - target: NSObject
    internal func removeActions(withKeys keys: [SKAction.Key], target: NSObject) {
        objc_sync_enter(self)
        guard let map = weaks.object(forKey: target) else { return }
        for key in keys {
            map.removeObject(forKey: key)
        }
        objc_sync_exit(self)
    }
    
    /// remove all actions of target object
    /// - Parameter target: NSObject
    internal func removeAllActions(of target: NSObject) {
        objc_sync_enter(self)
        weaks.removeObject(forKey: target)
        objc_sync_exit(self)
    }
    
    /// removeAllActions
    internal func removeAllActions() {
        objc_sync_enter(self)
        weaks.removeAllObjects()
        objc_sync_exit(self)
    }
    
    /// action for key
    /// - Parameters:
    ///   - key: SKAction.Key
    ///   - target: NSObject
    /// - Returns: SKAction
    internal func action(forKey key: SKAction.Key, target: NSObject) -> SKAction? {
        guard let map = weaks.object(forKey: target), let action = map.object(forKey: key) else { return nil }
        return action
    }
    
    /// map for target object
    /// - Parameter target: NSObject
    /// - Returns: NSMapTable<SKAction.Key, SKAction>
    internal func map(of target: AnyObject) -> NSMapTable<SKAction.Key, SKAction>? {
        guard let map = weaks.object(forKey: target) else { return nil }
        return map
    }
}
