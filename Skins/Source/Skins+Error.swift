//
//  Skins+Error.swift
//  Skin
//
//  Created by tramp on 2020/7/24.
//  Copyright © 2020 tramp. All rights reserved.
//

import Foundation

public struct SKError: Error {
    
    private let message: String
    
    /// localizedDescription
    public var localizedDescription: String {
        return "error message: \(message)"
    }
    
    /// 构建
    /// - Parameter message: error message
    public init(message: String) {
        self.message = message
    }
    
}
