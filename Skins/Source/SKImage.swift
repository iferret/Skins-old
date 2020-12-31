//
//  SKImage.swift
//  VDiskMobileLite
//
//  Created by tramp on 2020/10/28.
//

import UIKit

/// SKImage
public struct SKImage {
    public let image: UIImage?
    public let color: SKColor
    public let opaque: Bool
    
    /// 构建
    /// - Parameters:
    ///   - image: UIImage
    ///   - color: SKColor
    ///   - opaque: Bool
    public init(image: UIImage?, color: SKColor, opaque: Bool = false) {
        self.image = image
        self.color = color
        self.opaque = opaque
    }
}
