//
//  SQLManager.swift
//  ipfsFileTest1
//
//  Created by Miaoshi Wu on 4/7/18.
//  Copyright © 2018 Miaoshi Wu. All rights reserved.
//

import Cocoa

let DBFILE_NAME = "UserTable.sqlite"

public class SQLManager : NSObject {
    static let instance = SQLManager();
    var db : OpaquePointer? = nil
    class func shareInstance() -> SQLManager {
        return instance
    }
    
    func getFilePath() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        let DBPath = (documentPath! as NSString).appendingPathComponent(DBFILE_NAME)
        print("the path of DBFile is \(DBPath)")
        return DBPath
    }
    
    func createDataBaseTableIfNeeded() {
        let cDBPath = getFilePath().cString(using: String.Encoding.utf8)
        
        if sqlite3_open(cDBPath, &db) != SQLITE_OK {
            print("open DB fail！")
        } else {
            print("DB open error")
            let createUserTableSQL = "create table if not exists usertable(userName varchar(20) primary key, password varchar(12), email varchar(20), region integer(10));"
            if execSQL(SQL: createUserTableSQL) == false {
                print("create query error")
            } else {
                print("create UserTable success！")
            }
        }
    }
    
    func queryDataBase(querySQL : String) -> [[String : AnyObject]]? {
        var statement : OpaquePointer? = nil
        
        if querySQL.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            let cQuerySQL = (querySQL.cString(using: String.Encoding.utf8))!
            if sqlite3_prepare_v2(db, cQuerySQL, -1, &statement, nil) == SQLITE_OK {
                var queryDataArr = [[String: AnyObject]]()
                while sqlite3_step(statement) == SQLITE_ROW {
                    let columnCount = sqlite3_column_count(statement)
                    var temp = [String : AnyObject]()
                    for i in 0..<columnCount {
                        let cKey = sqlite3_column_name(statement, i)
                        let key : String = String(validatingUTF8: cKey!)!
                        let cValue = sqlite3_column_text(statement, i)
                        let value = String(cString: cValue!)
                        temp[key] = value as AnyObject
                    }
                    queryDataArr.append(temp)
                }
                return queryDataArr
            }
        }
        return nil
    }

    func execSQL(SQL : String) -> Bool {
        let cSQL = SQL.cString(using: String.Encoding.utf8)
        let errmsg : UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? = nil
        if sqlite3_exec(db, cSQL, nil, nil, errmsg) == SQLITE_OK {
            return true
        } else {
            print("Query error:\(String(describing: errmsg))")
            return false
        }
    }
    
    
    
}
