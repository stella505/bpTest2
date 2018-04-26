//
//  LoginInPage.swift
//  
//
//  Created by Miaoshi Wu on 4/23/18.
//

import Cocoa

class LoginInPage: NSViewController {
    var db:SQLiteDB!
    
    @IBOutlet weak var _userName: NSTextField!
    @IBOutlet weak var _password: NSSecureTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = SQLiteDB.shared
    }
    
    @IBOutlet weak var _Ok: NSButton!
    
    @IBAction func OkButton(_ sender: NSButton) {
        DoLogin()
        shell("ipfs daemon")
    }
//    @IBAction func LoginButton(_ sender: Any) {
//        
//    }
    func DoLogin(){
        let UserName = _userName.stringValue
        let Password = _password.stringValue
        if (UserName == "" || Password == "")
        {
            return
        }
        let sql = "select * from usertable where (userName = '\(UserName)'and password = '\(Password)')"
        let data = db.execute(sql:sql)
        print("sql:\(sql) => \(data)")
        //        if SQLManager.shareInstance().execSQL(SQL: sql) == true {
        //            print("search success!")
        //        }
        if data == 0{
            return
        }
        
        self.view.window?.close()
    }
    @discardableResult
    func shell(_ args: String...) -> Int32 {
        
        let task = Process()
        let pipe = Pipe()
        task.launchPath = "/Users/miaoshiwu/"
        task.arguments = args
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
        print(output!)
        task.waitUntilExit()
        return task.terminationStatus
    }
}
