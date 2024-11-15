//// 
//  ChatVo.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/9/2
//  
//
//

import Foundation

struct ChatVo: Hashable {
    var id = 0
    var name = ""
    var content = ""
    var time = ""
    var sort = 0
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    public static func == (lhs: ChatVo, rhs: ChatVo) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(id: Int = 0) {
        self.id = id
    }
    
    init (id: Int, name: String, content: String, time: String, sort: Int) {
        self.id = id
        self.name = name
        self.content = content
        self.time = time
        self.sort = sort
    }
}
