//// 
//  TestCoroutine.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/4
//  
//
//

import Foundation

class TestCoroutine {
//    static let `default` = TestCoroutine()
    let basicTask = Task {
        return "This is the result of the task"
    }
    
    func test1() async throws {
//        await enableData.setEnable(isEnable: false)
        let duration = UInt64(1 * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
        print("TestCoroutine 1111 is main \(Thread.current)")
        async let result = TestCoroutine1.test1()
        let rr = try await result
        print("TestCoroutine 33333 result is result \(rr)")
    }
    
    static func test2() async throws {
        let duration = UInt64(2 * 1_000_000_000)
        try await Task.sleep(nanoseconds:duration)
        print("test 1111 is main \(Thread.current)")
    }
    
}
