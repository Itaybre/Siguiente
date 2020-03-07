//
//  AppDelegate.swift
//  Siguiente
//
//  Created by Itay Brenner on 2/20/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusBarManager: StatusBarManager!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarManager = StatusBarManager()
    }
}

