//// 
//  StringUtils.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2025/1/11
//  
//
//

import Foundation

class StringUtils {
    
    /// 生成随机中文字符
    static func generateRandomChineseCharacter() -> String {
        // Unicode 范围：0x4E00 - 0x9FFF
        let start: UInt32 = 0x4E00
        let end: UInt32 = 0x9FFF
        
        // 随机生成范围内的 Unicode 编码
        let randomCode = UInt32.random(in: start...end)
        
        // 转换为字符
        if let scalar = UnicodeScalar(randomCode) {
            return String(scalar)
        }
        return ""
    }

    /// 生成指定数量的随机中文字符串
    static func generateRandomChineseString(count: Int) -> String {
        (0..<count).map { _ in generateRandomChineseCharacter() }.joined()
    }
    
}
