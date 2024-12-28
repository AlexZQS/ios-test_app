////
//  Student.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/8
//
//
//

import Foundation
import WCDBSwift

class StudentModel: TableCodable {
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
}
