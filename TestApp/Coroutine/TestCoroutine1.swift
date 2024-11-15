//// 
//  TestCoroutine1.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/12
//  
//
//

import Foundation

class TestCoroutine1 {
    
    static func test1() async throws -> Int {
        print("TestCoroutine1 test1 start is main \(Thread.current)")
        let duration = UInt64(3 * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
        print("TestCoroutine1 test1 end is main \(Thread.current)")
        return 1
    }
}
