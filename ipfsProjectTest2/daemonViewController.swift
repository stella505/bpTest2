//
//  daemonViewController.swift
//  ipfsFileTest1
//
//  Created by Miaoshi Wu on 4/7/18.
//  Copyright © 2018 Miaoshi Wu. All rights reserved.
//

import Cocoa

class daemonViewController: NSViewController {

    @IBAction func DaemonButton(_ sender: Any) {
        shell("ipfs daemon")
    }
    @discardableResult
    func shell(_ args: String...) -> Int32 {
        
        let task = Process()
        let pipe = Pipe()
        task.launchPath = "/Users/miaoshiwu/.ipfs/"
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
