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
    var id: String = ""
    var name: String? = nil
    
    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = StudentModel
        case id
        case name
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(id, isPrimary: true)
            BindColumnConstraint(name, isNotNull: true, defaultTo: "defaultDescription")
        }
        
    }
}
