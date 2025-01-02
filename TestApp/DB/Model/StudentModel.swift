////
//  Student.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/8
//
//
//

import Foundation
import WCDBSwift

final class StudentModel: TableCodable {
    var id: Int?
    var userId: String = ""
    var name: String? = nil
    
    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = StudentModel
        case id
        case name
        case userId
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(id, isPrimary: true,isAutoIncrement: true)
            BindColumnConstraint(userId, isNotNull: true, defaultTo: "defaultDescription")
            BindColumnConstraint(name, isNotNull: true, defaultTo: "defaultDescription")
            BindIndex(userId, namedWith: "StudentModel_userId_index", isUnique: true)
        }
    }
    
    var isAutoIncrement: Bool = true // 用于定义是否使用自增的方式插入
    var lastInsertedRowID: Int64 = 0 // 用于获取自增插入后的主键值
}
