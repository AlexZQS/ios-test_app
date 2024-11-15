//// 
//  MessageVo.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/9/14
//  
//
//

import Foundation

struct MessageVo: Hashable {
    var id  = 0
    var content = ""
    var name = ""
    var sort = 0
    var time = 0
    
    init(id: Int, content: String, name: String, sort: Int, time: Int) {
        self.id = id
        self.content = content
        self.name = name
        self.sort = sort
        self.time = time
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
//    public static func == (lhs: ChatVo, rhs: ChatVo) -> Bool {
//        return lhs.id == rhs.id && lhs.content == rhs.content
//    }
    public static func == (lhs: MessageVo, rhs: MessageVo) -> Bool {
        return lhs.id == rhs.id
    }
}
