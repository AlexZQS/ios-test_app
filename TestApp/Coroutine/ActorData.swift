//// 
//  ActorData.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/12
//  
//
//

import Foundation

actor ActorData {
    
    private var lastPos = 0
    
    private var mChatMessageCache = [Int:ChatMessageCache]()
    
    func getLastPos() -> Int {
        return lastPos
    }
    
    func setLastPos() {
        self.lastPos = self.lastPos + 1
    }
    
    func getChatMessageCache(chatId: Int,count: Int) async -> ChatMessageCache {
        if let cache = mChatMessageCache[chatId] {
            cache.loadCount = count
            return cache
        }
        
        let cache = ChatMessageCache()
        cache.loadCount = count
        mChatMessageCache[chatId] = cache
        return cache
    }
    
    func getChatMessageCache(chatId: Int) async -> ChatMessageCache {
        if let cache = mChatMessageCache[chatId] {
            return cache
        }
        
        let cache = ChatMessageCache()
        mChatMessageCache[chatId] = cache
        return cache
    }
    
    func test1() async throws {
        print("ActorData test1 start is main \(Thread.current)")
//        let duration = UInt64(2 * 1_000_000_000)
//        try await Task.sleep(nanoseconds: duration)
        setLastPos()
//        try await TestCoroutine1.test1()
        print("ActorData test1 end is main \(Thread.current) data = \(self.lastPos) map = \(self.mChatMessageCache[1]?.loadCount)")
    }
    
    
//    func initKiwi() -> String {
//        self.lock.lock()
//
//        defer { self.lock.unlock() }
//        
//    }
    
}

public class ChatMessageCache {
    //历史消息
    var historyMessages = Set<Int>()
    
    // 当前聊天室拉取条数
    var loadCount = 0;
    
    //实时消息
    var realTimeMessages = Set<Int>()
    
}

