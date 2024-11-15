//// 
//  DBUtils.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/14
//  
//
//

import Foundation
import WCDBSwift

class DBUtils {
    
    static func initDB() -> Database {
        let path = getDocumentPath()
        let dbPath = path + "/document/UserDb.db"
        let dataBase = Database.init(at: dbPath)
        return dataBase
    }
    
    static func getDocumentPath() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        guard let path = documentPath else {
            return ""
        }
        return path
    }
    
}
