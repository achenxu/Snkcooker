//
//  AppDelegate.swift
//  snkcooker
//
//  Created by luiyezheng on 2017/12/16.
//  Copyright © 2017年 luiyezheng. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if let window = sender.windows.first {
            if flag {
                window.orderFront(nil)
            } else {
                window.makeKeyAndOrderFront(nil)
            }
        }
        return true
    }
}

