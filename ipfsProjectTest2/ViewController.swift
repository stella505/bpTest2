//
//  ViewController.swift
//  ipfsProjectTest2
//
//  Created by Miaoshi Wu on 4/22/18.
//  Copyright © 2018 Miaoshi Wu. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var db:SQLiteDB!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = SQLiteDB.shared
        //let sqlM = SQLManager()
        //let dbpath = sqlM.getFilePath()
        //sqlM.createDataBaseTableIfNeeded()
        let dbpath = "/Users/miaoshiwu/Desktop/ipfsFileTest2/data.db"
        db.open(dbPath:dbpath, copyFile:true)
        db.execute(
            sql: "create table if not exists usertable(userName varchar(20) primary key, password varchar(12), email varchar(20), region integer(10))"
        )
        //  "/Users/miaoshiwu/Desktop/ipfsFileTest2/data.db
        //  Do any additional setup after loading the view.
        //initUser()
    }
//    func initUser(){
//        let data = db.query(sql: "select userName,password from usertable")
//        if data.count > 0 {
//            let user = data[data.count - 1]
//            _userName.stringValue = user["userName"] as! String
//            _password.stringValue = user["password"] as! String
//        }
//    }

    @IBOutlet weak var SignUpButton: NSButton!
    @IBOutlet weak var LoginButton: NSButton!
    
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

