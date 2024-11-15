//
//  IMQueue.swift
//  CommonModule
//
//  Created by Joey on 2023/6/12.
//

import Foundation
 
public class UUQueue<T> {
        
    var underlying: T?
    private var queue: DispatchQueue

    public init(lable: String, initT: @escaping (() -> T)) {
        self.queue = DispatchQueue.init(label: lable)
//        self.queue.async {
        self.queue.sync {
            let t = initT()
            self.underlying = t
        }
        //Task
    }
    
    public func getQueueLabel() -> String {
        return self.queue.label
    }
    
    func excuteTask<R>(block:@escaping ((T) throws -> R)) async throws -> R {
        return try await withCheckedThrowingContinuation({ continuation in
            do {
                let r: R = try block(self.underlying!)
                continuation.resume(returning: r)
            } catch {
                continuation.resume(throwing: error)
            }
//            self.queue.async {
            
            
//                do {
//                    let r: R = try block(self.underlying!)
//                    continuation.resume(returning: r)
//                } catch {
//                    continuation.resume(throwing: error)
//                }
//            }
        })

    }
//    public func en(block:@escaping ((T) -> Void)) {
//        self.queue.async {
////            SDKDebugLog("IMQueue ---> \(self.underlying!) current:\(Thread.current)")
//            block(self.underlying!)
//        }
//    }
//    
//    public func syncTask(block:@escaping ((T) -> Void)) {
//        self.queue.sync {
////            SDKDebugLog("IMQueue ---> \(self.underlying!) current:\(Thread.current)")
//            block(self.underlying!)
//        }
//    }
}

//@available(iOS 13.0.0, *)
//public extension UUQueue {
//    
//    func excuteTask<R>(block:@escaping ((T) throws -> R)) async throws -> R {
//        
//        return try await withCheckedThrowingContinuation({ continuation in
//            
//            self.queue.async {
//                do {
//                    let r: R = try block(self.underlying!)
//                    continuation.resume(returning: r)
//                } catch {
//                    continuation.resume(throwing: error)
//                }
//            }
//        })
//
//    }
//    
//    
//}


