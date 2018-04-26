//
//  theFirstPage.swift
//  ipfsFileTest1
//
//  Created by Miaoshi Wu on 4/16/18.
//  Copyright © 2018 Miaoshi Wu. All rights reserved.
//

import Cocoa

class theFirstPage: NSViewController {
    
    @IBOutlet weak var _IPFSidVIew: NSScrollView!
    @IBOutlet weak var _IPAddressView: NSScrollView!
    @IBOutlet weak var _OutputView: NSScrollView!
    
    @IBAction func IPFSinfo(_ sender: Any) {
        let output = _OutputView
        let attributedString = NSMutableAttributedString(string: shell("ipfs id"))
        output?.insertText(attributedString)
//output.textStorage.mutableString.setString()
    }

    @IBAction func IPFSbootstat(_ sender: Any) {
        let output = _OutputView
        let attributedString = NSMutableAttributedString(string: shell("ipfs bootstats"))
        output?.insertText(attributedString)
    }
    
    @IBAction func SwarmPeers(_ sender: Any) {
        let output = _OutputView
        let attributedString = NSMutableAttributedString(string: shell("ipfs swarm peers"))
        output?.insertText(attributedString)
    }
    @IBOutlet weak var TransferFile: NSButton!
    
    @IBAction func CloseIPFS(_ sender: Any) {
        shell("clear")
    }
    @discardableResult
    func shell(_ args: String...) -> String {
        
        let task = Process()
        let pipe = Pipe()
        task.launchPath = "/Users/miaoshiwu"
        task.arguments = args
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
        task.waitUntilExit()
        print(output!)
        return output! as String
        //return task.terminationStatus
    }
}
