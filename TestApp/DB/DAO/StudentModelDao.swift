//// 
//  StudentModelDao.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/8
//  
//
//

import Foundation
import WCDBSwift

class StudentModelDao {
    
    static var table_name = "user"
    
    static func createTable(userDB: Database?,tableName: String) throws {
//        self.table_name = tableName
        guard let db = userDB else {
            return
        }
        try db.create(table: tableName, of: StudentModel.self)
    }
    
    static func queryUserIds(userDB: Database?) async throws -> [String] {
        guard let db = userDB else {
            return []
        }
        
        let result = try db.getColumn(on: StudentModel.Properties.id, fromTable: table_name)
        var ids = [String]()
        for column in result {
            ids.append(column.stringValue)
        }
        return ids
    }
    
    static func queryUsers(userDB: Database?) async throws -> [StudentModel] {
        guard let db = userDB else {
            return []
        }
        let result: [StudentModel] = try db.getObjects(fromTable: table_name)
        return result
    }
    
    static func queryUser(userDB: Database?,userId: String) async throws -> StudentModel? {
        guard let db = userDB else {
            return nil
        }
        let condition: Condition = StudentModel.CodingKeys.userId == userId
        let result: StudentModel? = try db.getObject(fromTable: table_name,where: condition)
        return result
    }
    
    static func insertUser(userDB: Database?,users: [StudentModel]) async throws {
        guard let db = userDB else {
            return
        }
        try db.insert(users, intoTable: table_name)
    }
    
    static func insertUser(userDB: Database?,student: StudentModel) async throws {
        guard let db = userDB else {
            return
        }
        try db.insert(student, intoTable: table_name)
    }
    
    static func handleInsert(userDB: Database?,student: StudentModel) async throws {
        guard let db = userDB else {
            return
        }
        
//        let properites = [
//            StudentModel.Properties.userId,
//            StudentModel.Properties.name,
//        ]
        
        let insert = StatementInsert().insert(intoTable: table_name)
//        for user in users {
//            let name = user.name ?? ""
//            insert.columns(Column(named: "userId"),Column(named: "name"))
//                .values(user.userId,name)
//                .onConflict(.Ignore)
//                
//        }
        
        let name = student.name ?? ""
        insert.columns(Column(named: "userId"),Column(named: "name"))
            .values(student.userId,name)
            .onConflict(.Ignore)
        
        
        let handle = try db.getHandle()
        let stmt = try handle.getOrCreatePreparedStatement(with: insert)
        try stmt.step()
        handle.finalizeAllStatement()
    }
    
    static func updateUser(userDB: Database?,id: String,name: String) async throws {
        guard let db = userDB else {
            return
        }
        let user = StudentModel()
        let properites = [
            StudentModel.Properties.name,
        ]
        
        user.name = name
        try db.update(table: table_name, on: properites, with: user, where: StudentModel.Properties.id == id)
    }
    
    static func clear(userDB: Database?) async throws {
        guard let db = userDB else {
            return
        }
        try db.delete(fromTable: table_name)
    }
    
    static func insertUsers2(queue: UUQueue<Database>?,users: [StudentModel]) async throws {
        guard let mQueue = queue else {
            return
        }
        
        try await mQueue.excuteTask { dbBase in
            
            try dbBase.run(transaction: { handle in
                    
                try dbBase.insert(users, intoTable: table_name)
            })
        }
//
//        let properites = [
//            StudentModel.Properties.id,
//            StudentModel.Properties.name,
//        ]
        
        
    }
    
    static func insertUsers1(userDB: Database?,users: [StudentModel]) async throws {
        guard let db = userDB else {
            return
        }
    
        let properites = [
            StudentModel.Properties.userId,
            StudentModel.Properties.name,
        ]
        
//        let up = Upsert().onConflict().indexed(by: StudentModel.Properties.id).doUpdate().set(StudentModel.Properties.name)
//        
//        let statementInsert = StatementInsert().insert(intoTable:table_name )
//            .with()
       
        let insert = StatementInsert().insert(intoTable: table_name)
        
        for user in users {
            let name = user.name ?? ""
            insert.columns(Column(named: "userId"),Column(named: "name"))
                .values(user.userId,name)
                .onConflict(.Ignore)
                
        }
        let handle = try db.getHandle()
        let stmt = try handle.getOrCreatePreparedStatement(with: insert)
        try stmt.step()
        let data = try insert.onConflict()
        handle.finalizeAllStatement()
//        print(data)
    }
    
    static func insertUsers(userDB: Database?,users: [StudentModel]) async throws {
        guard let db = userDB else {
            return
        }
        
        let properites = [
            StudentModel.Properties.id,
            StudentModel.Properties.name,
        ]
        
        ///TODO: 123123123
        try db.run(transaction: { handle in
            var updateUsers = [StudentModel]()
            let insert: Insert = try db.prepareInsertOrIgnore(of: StudentModel.self, intoTable: table_name)
            try insert.execute(with: users)
            
//            for user in users {
//                do {
//                    try db.insert(user, intoTable: table_name)
//                } catch {
//                    try db.update(table: table_name, on: properites, with: user, where: StudentModel.Properties.id == user.id)
//                }
//            }
            
//            for user in updateUsers {
//                let properites = [
//                    StudentModel.Properties.name,
//                ]
//                
//                user.name = user.name
//                
//                try db.update(table: table_name, on: properites, with: user, where: StudentModel.Properties.id == user.id)
//            }
            
            
        })
    }
    
    
    
}
