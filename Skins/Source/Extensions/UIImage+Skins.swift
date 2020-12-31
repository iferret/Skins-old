//
//  UIImage+Skins.swift
//  VDiskMobileLite
//
//  Created by tramp on 2020/10/28.
//

import UIKit

extension UIImage: SkinsCompatible {}
extension SkinsWrapper where Base: UIImage {
    
    /// change tint color
    /// - Parameter color: UIColor
    /// - Returns: UIImage
    public func tint(color: UIColor, opaque: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(base.size, opaque, base.scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return base
        }
        context.translateBy(x: 0, y: base.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: base.size.width, height: base.size.height))
        context.clip(to: rect, mask: base.cgImage!)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? base
    }
    
    /// 渲染模式
    /// - Parameter mode: UIImage.RenderingMode
    /// - Returns: UIImage
    public func render(mode: UIImage.RenderingMode) -> UIImage {
        return base.withRenderingMode(mode)
    }
    
}
