//
//  SFSafariViewController+Extensions.swift
//  VDiskMobileLite
//
//  Created by tramp on 2020/11/13.
//

import Foundation
import SafariServices

extension SFSafariViewController: SkinsCompatible {}

// MARK: - SFSafariViewController
extension SkinsWrapper where Base: SFSafariViewController {
    
    /** @abstract The preferred color to tint the background of the navigation bar and toolbar. If SFSafariViewController is in Private
        Browsing mode or is displaying an anti-phishing warning page, this color will be ignored. Changes made after the view controller
        has been presented will not be reflected.
     */
    @available(iOS 10.0, *)
    public var preferredBarTintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.preferredBarTintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }

    
    /** @abstract The preferred color to tint the control buttons on the navigation bar and toolbar. If SFSafariViewController is in Private
        Browsing mode or is displaying an anti-phishing warning page, this color will be ignored. Changes made after the view controller
        has been presented will not be reflected.
     */
    @available(iOS 10.0, *)
    public var preferredControlTintColor: SKColor? {
        get { Skins.shared.action(forKey: .init(string: #function), target: base)?.color }
        set {
            let action = SKAction.init(entity: .color(newValue, {[weak base] (style, color) in
                base?.preferredControlTintColor = color?.current(with: style)
            })).run()
            Skins.shared.add(action: action, forKey: .init(string: #function), target: base)
        }
    }
    
    
}
