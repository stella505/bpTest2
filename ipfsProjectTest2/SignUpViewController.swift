//
//  SignUpViewController.swift
//  ipfsFileTest1
//
//  Created by Miaoshi Wu on 4/2/18.
//  Copyright © 2018 Miaoshi Wu. All rights reserved.
//

import Cocoa

class SignUpViewController: NSViewController  {
    
    var db:SQLiteDB!
    
    @IBOutlet weak var _usernametable: NSTextField!
    @IBOutlet weak var _passwordtable: NSTextField!
    @IBOutlet weak var _emailtable: NSTextField!
    @IBOutlet weak var _regiontable: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = SQLiteDB.shared
        //let sqlM = SQLManager()
        //let dbpath = sqlM.getFilePath()
        //db.open(dbPath:dbpath, copyFile:true)
        //db.open(dbPath: "~/Desktop/ipfsFileTest2/data.db", copyFile: true)
        //db.execute(
        //    sql: "create table if not exists usertable(userName varchar(20) primary key, password varchar(12), email varchar(20), region integer(10))"
        //)
        //initUser()
    }
    func initUser(){
        let data = db.query(sql: "select * from usertable")
        if data.count > 0 {
            let user = data[data.count - 1]
            _usernametable.stringValue = user["userName"] as! String
            _passwordtable.stringValue = user["password"] as! String
            _emailtable.stringValue = user["email"] as! String
            _regiontable.stringValue = user["region"] as! String
        }
    }
    @IBAction func saveButton(_ sender: Any) {
        saveUser()
    }
    
    func saveUser(){
        let UserName = _usernametable.stringValue
        let Password = _passwordtable.stringValue
        let Email = _emailtable.stringValue
        let Region = _regiontable.stringValue
        if (UserName == "" || Password == "" || Email == "" || Region == "")
        {
            return
        }
        let sql = "insert into usertable(userName,password,email,region) values('\(UserName)','\(Password)','\(Email)','\(Region)')"
        print("sql:\(sql)")
        let result = db.execute(sql: sql)
        print(result)
        self.view.window?.close()
    }
    
}
